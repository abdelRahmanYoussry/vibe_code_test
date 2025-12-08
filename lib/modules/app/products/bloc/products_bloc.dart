import 'package:test_vibe/modules/app/products/repo/product_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import 'products_state.dart';

class ProductsBloc extends Cubit<ProductsState> {
  ProductsBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.productsRepo,
  }) : super(const ProductsState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final ProductsRepo productsRepo;

  int topRequestedProductsPageNumber = 1;
  bool topRequestedProductsIsLastPage = false;
  int signaturesProductsPageNumber = 1;
  bool signaturesProductsIsLastPage = false;

  int newlyReleasedProductsPageNumber = 1;
  bool newlyReleasedProductsIsLastPage = false;

  Future<void> getTopRequestedProducts() async {
    topRequestedProductsPageNumber = 1;
    emit(state.copyWith(topRequestedProductsDataState: state.topRequestedProductsDataState.asLoading()));
    final f = await productsRepo.getTopRequestedProducts(topRequestedProductsPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          topRequestedProductsDataState: state.topRequestedProductsDataState.asLoadingFailed(l),
        ),
      ),
      (r) {
        topRequestedProductsPageNumber = 2;
        if (r.length != 10) {
          topRequestedProductsIsLastPage = true;
        } else {
          topRequestedProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            topRequestedProductsDataState: state.topRequestedProductsDataState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreTopRequestedProducts() async {
    if (state.topRequestedProductsDataState.loadingState.loading ||
        state.topRequestedProductsDataState.loadingState.reloading ||
        topRequestedProductsIsLastPage) {
      return;
    }
    emit(state.copyWith(topRequestedProductsDataState: state.topRequestedProductsDataState.asReloading()));
    final f = await productsRepo.getTopRequestedProducts(topRequestedProductsPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          topRequestedProductsDataState: state.topRequestedProductsDataState.asReloadingFailed(l),
        ),
      ),
      (r) {
        topRequestedProductsPageNumber += 1;
        if (r.length != 10) {
          topRequestedProductsIsLastPage = true;
        } else {
          topRequestedProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            topRequestedProductsDataState: state.topRequestedProductsDataState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }

  Future<void> getSignaturesProducts() async {
    signaturesProductsPageNumber = 1;
    emit(state.copyWith(signaturesProductsDataState: state.signaturesProductsDataState.asLoading()));
    final f = await productsRepo.getSignaturesProducts(signaturesProductsPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          signaturesProductsDataState: state.signaturesProductsDataState.asLoadingFailed(l),
        ),
      ),
      (r) {
        signaturesProductsPageNumber = 2;
        if (r.length != 10) {
          signaturesProductsIsLastPage = true;
        } else {
          signaturesProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            signaturesProductsDataState: state.signaturesProductsDataState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreSignaturesProducts() async {
    if (state.signaturesProductsDataState.loadingState.loading ||
        state.signaturesProductsDataState.loadingState.reloading ||
        signaturesProductsIsLastPage) {
      return;
    }
    emit(state.copyWith(signaturesProductsDataState: state.signaturesProductsDataState.asReloading()));
    final f = await productsRepo.getSignaturesProducts(signaturesProductsPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          signaturesProductsDataState: state.signaturesProductsDataState.asReloadingFailed(l),
        ),
      ),
      (r) {
        signaturesProductsPageNumber += 1;
        if (r.length != 10) {
          signaturesProductsIsLastPage = true;
        } else {
          signaturesProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            signaturesProductsDataState: state.signaturesProductsDataState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }

  Future<void> getProductDetails({required int productId}) async {
    emit(state.copyWith(productDetailsState: state.productDetailsState.asLoading()));
    final f = await productsRepo.getProductDetails(productId);
    f.fold(
      (l) => emit(
        state.copyWith(
          productDetailsState: state.productDetailsState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            productDetailsState: state.productDetailsState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> newlyReleasedProducts() async {
    newlyReleasedProductsPageNumber = 1;
    emit(state.copyWith(newlyReleasedProductsDataState: state.newlyReleasedProductsDataState.asLoading()));
    final f = await productsRepo.getNewlyReleasedProducts(newlyReleasedProductsPageNumber.toString());
    f.fold(
          (l) => emit(
        state.copyWith(
          newlyReleasedProductsDataState: state.newlyReleasedProductsDataState.asLoadingFailed(l),
        ),
      ),
          (r) {
        newlyReleasedProductsPageNumber = 2;
        if (r.length != 10) {
          newlyReleasedProductsIsLastPage = true;
        } else {
          newlyReleasedProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            newlyReleasedProductsDataState: state.newlyReleasedProductsDataState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreNewlyReleasedProducts() async {
    if (state.newlyReleasedProductsDataState.loadingState.loading ||
        state.newlyReleasedProductsDataState.loadingState.reloading ||
        newlyReleasedProductsIsLastPage) {
      return;
    }
    emit(state.copyWith(newlyReleasedProductsDataState: state.newlyReleasedProductsDataState.asReloading()));
    final f = await productsRepo.getNewlyReleasedProducts(newlyReleasedProductsPageNumber.toString());
    f.fold(
          (l) => emit(
        state.copyWith(
          newlyReleasedProductsDataState: state.newlyReleasedProductsDataState.asReloadingFailed(l),
        ),
      ),
          (r) {
        newlyReleasedProductsPageNumber += 1;
        if (r.length != 10) {
          newlyReleasedProductsIsLastPage = true;
        } else {
          newlyReleasedProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            newlyReleasedProductsDataState: state.newlyReleasedProductsDataState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }
}
