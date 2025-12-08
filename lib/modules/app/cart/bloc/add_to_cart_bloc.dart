import 'package:collection/collection.dart';
import 'package:test_vibe/modules/app/cart/repo/add_to_cart_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../../products/models/product_model_api.dart';
import '../../products/repo/product_repo.dart';
import '../add_to_cart_params.dart';
import 'add_to_cart_state.dart';

class AddToCartBloc extends Cubit<AddToCartState> {
  AddToCartBloc({
    required this.cacheHelper,
    required this.langRepo,
    required this.productsRepo,
    required this.addToCartRepo,
  }) : super(const AddToCartState());

  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final ProductsRepo productsRepo;
  final AddToCartRepo addToCartRepo;

  Future<void> addCommentToProduct({required int productId, required String Comment}) async {
    emit(
      state.copyWith(
        addCommentToProductState: state.addCommentToProductState.asLoading(),
      ),
    );
    final f = await productsRepo.addCommentToProduct(
      productId: productId,
      Comment: Comment,
    );
    f.fold(
      (l) => emit(
        state.copyWith(
          addCommentToProductState: state.addCommentToProductState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            addCommentToProductState: state.addCommentToProductState.asLoadingSuccess(
              data: r,
              success: true,
            ),
          ),
        );
      },
    );
  }

  Future<void> addToCart({required AddToCartParams params}) async {
    emit(
      state.copyWith(
        addToCartDataState: state.addToCartDataState.asLoading(),
      ),
    );
    final f = await addToCartRepo.addToCart(params);
    f.fold(
      (l) {
        emit(
          state.copyWith(
            addToCartDataState: state.addToCartDataState.asLoadingFailed(l),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            addToCartDataState: state.addToCartDataState.asLoadingSuccess(
              data: r,
              success: true,
            ),
          ),
        );
        if (params.type == 'buy_x_get_y') {
          debugPrint('111111111111111111111111111111111111');
          eventBus.fire(RefreshBuyXGetYEvent());
        }
      },
    );
  }

  Future<void> getCartDetails({bool isSilent = false}) async {
    if (!isSilent) {
      emit(
        state.copyWith(
          getFromCartDataState: state.getFromCartDataState.asLoading(),
        ),
      );
    }
    final f = await addToCartRepo.getCart();
    f.fold(
      (l) {
        emit(
          state.copyWith(
            getFromCartDataState: state.getFromCartDataState.asLoadingFailed(l),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            getFromCartDataState: state.getFromCartDataState.asLoadingSuccess(
              data: r,
              success: true,
            ),
          ),
        );
      },
    );
  }

  Future<void> updateCart({required AddToCartParams params}) async {
    emit(
      state.copyWith(
        updateCartDataState: state.updateCartDataState.asLoading(),
      ),
    );
    final f = await addToCartRepo.updateCart(params);
    f.fold(
      (l) {
        emit(
          state.copyWith(
            updateCartDataState: state.updateCartDataState.asLoadingFailed(l),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            updateCartDataState: state.updateCartDataState.asLoadingSuccess(
              data: r,
              success: true,
            ),
          ),
        );
        getCartDetails(isSilent: true);
      },
    );
  }

  Future<void> deleteFromCart({required String productId, String? type}) async {
    emit(
      state.copyWith(
        removeItemFromCartState: state.removeItemFromCartState.asLoading(),
      ),
    );
    final f = await addToCartRepo.deleteCartItem(productId);
    f.fold(
      (l) {
        emit(
          state.copyWith(
            removeItemFromCartState: state.removeItemFromCartState.asLoadingFailed(l),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            removeItemFromCartState: state.removeItemFromCartState.asLoadingSuccess(
              data: r,
              success: true,
            ),
          ),
        );
        getCartDetails(isSilent: true);
        if (type == 'buy_x_get_y') {
          eventBus.fire(RefreshBuyXGetYEvent());
        }
      },
    );
  }

  Future<void> formatAndAddToCart({
    required ProductModelApi productModel,
    required Map<String, String?> selectedOptions,
    required int quantity,
  }) async {
    // Create the properly formatted options structure
    Map<String, Map<String, String>> formattedOptions = {};

    selectedOptions.forEach((optionId, selectedValueId) {
      if (selectedValueId != null) {
        // Find the option model to get the option type and value name
        final optionModel = productModel.productOptions.firstWhereOrNull(
          (option) => option.id == optionId,
        );

        if (optionModel != null) {
          // Find the selected value to get its name
          final selectedValue = optionModel.values.firstWhereOrNull(
            (value) => value.id == selectedValueId,
          );

          if (selectedValue != null) {
            formattedOptions[optionId] = {
              "option_type": "radio", // Assuming all are radio type based on the example
              "values": selectedValue.name,
            };
          }
        }
      }
    });

    debugPrint('Adding to cart: $quantity items with options: $formattedOptions');

    AddToCartParams params = AddToCartParams(
      productId: productModel.id,
      quantity: quantity.toString(),
      options: formattedOptions.isNotEmpty ? formattedOptions : null,
    );

    await addToCart(params: params);
  }
}
