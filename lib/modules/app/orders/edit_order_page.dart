import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/lists/vertical_list.dart';
import 'package:test_vibe/modules/app/orders/models/order_model.dart';
import 'package:test_vibe/modules/app/orders/models/order_detail_model.dart';
import 'package:test_vibe/modules/app/orders/models/update_order_params.dart';
import 'package:test_vibe/modules/app/orders/widgets/order_widget/edit_oder_over_view.dart';
import 'package:test_vibe/modules/app/orders/widgets/order_widget/edit_order_widget.dart';
import 'package:test_vibe/modules/app/products/models/product_model_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import 'package:test_vibe/core/di/di.dart';
import 'package:test_vibe/core/widgets/loading/circular_loading_widget.dart';
import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/lists/horizontal_list.dart';
import 'package:test_vibe/core/widgets/section_label/section_label.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/modules/app/products/products_page_params.dart';
import 'package:test_vibe/modules/app/products/widgets/product_item_with_add_button/product_item_with_add_button.dart';
import 'package:test_vibe/modules/app/products/bloc/products_bloc.dart';
import 'package:test_vibe/modules/app/products/bloc/products_state.dart';
import '../../../core/theme/constants/app_colors.dart';
import '../../../core/widgets/empty/empty_widget.dart';
import 'bloc/edit_order_bloc.dart';
import 'bloc/edit_order_state.dart';

class EditOrderPage extends StatefulWidget {
  final OrderModel orderModel;

  const EditOrderPage({super.key, required this.orderModel});

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  late final ValueNotifier<List<OrderProductModel>> _editableProductsNotifier;
  late final ValueNotifier<Map<int, int>> _productQuantitiesNotifier;
  OrderDetailModel? orderDetail;
  String? description;
  OrderAddressModel? address;

  List<OrderProductModel> get _editableProducts => _editableProductsNotifier.value;

  Map<int, int> get _productQuantities => _productQuantitiesNotifier.value;

  @override
  void initState() {
    super.initState();
    final initialProducts =
        widget.orderModel.products.where((product) => !product.isOffer && !product.isFreeOffer).toList();
    _editableProductsNotifier = ValueNotifier<List<OrderProductModel>>(initialProducts);
    _productQuantitiesNotifier = ValueNotifier<Map<int, int>>({
      for (final product in initialProducts) product.id: product.qty,
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditOrderBloc>().getOrderDetails(widget.orderModel.orderId);
    });
  }

  @override
  void dispose() {
    _editableProductsNotifier.dispose();
    _productQuantitiesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacingTheme = SpacingTheme.of(context);

    return BlocProvider(
      create: (context) => di<EditOrderBloc>(),
      child: BlocListener<EditOrderBloc, EditOrderState>(
        listener: (context, state) {
          if (state.updateOrderDetailsState.success == true) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.updateOrderDetailsState.data?.message ?? 'Order updated successfully',
              isSuccess: true,
            );
            Navigator.of(context).pop();
          }

          if (state.deleteOrderProductState.success == true && state.deleteOrderProductState.data?.data != null) {
            _applyOrderDetail(state.deleteOrderProductState.data!.data!);
            // SnackBarBuilder.showFeedBackMessage(
            //   context,
            //   state.deleteOrderProductState.data?.message ??
            //       'Product removed successfully',
            //   isSuccess: true,
            // );
          }

          if (state.getOrderDetailsState.success == true && state.getOrderDetailsState.data?.data != null) {
            _applyOrderDetail(state.getOrderDetailsState.data!.data!);
          }

          if (state.updateOrderDetailsState.error != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.updateOrderDetailsState.error!,
              isSuccess: false,
            );
          }
          if (state.deleteOrderProductState.error != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.deleteOrderProductState.error!,
              isSuccess: false,
            );
          }
          if (state.getOrderDetailsState.error != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.getOrderDetailsState.error!,
              isSuccess: false,
            );
          }
        },
        child: ValueListenableBuilder<List<OrderProductModel>>(
          valueListenable: _editableProductsNotifier,
          builder: (context, editableProducts, _) {
            return ValueListenableBuilder<Map<int, int>>(
              valueListenable: _productQuantitiesNotifier,
              builder: (context, productQuantities, __) {
                return CustomScaffold(
                  appBar: CustomAppbar(
                    title: Text(
                      '${Loc.of(context).edit_order} #${widget.orderModel.orderId}',
                    ),
                  ),
                  body: BlocBuilder<EditOrderBloc, EditOrderState>(
                    builder: (context, state) {
                      final isLoadingDetails = state.getOrderDetailsState.loadingState.loading;
                      final isLoadingUpdate = state.updateOrderDetailsState.loadingState.loading;
                      final isLoadingDelete = state.deleteOrderProductState.loadingState.loading;

                      if (isLoadingDetails && editableProducts.isEmpty) {
                        return Center(
                          child: SizedBox(
                            height: 100.h,
                            child: const Center(child: CircularLoadingWidget()),
                          ),
                        );
                      }

                      if (editableProducts.isEmpty) {
                        return EmptyWidget(
                          title: Loc.of(context).cart_is_empty,
                        );
                      }

                      return CustomScrollView(
                        slivers: [
                          VerticalSliverListView(
                            padding: spacingTheme.pagePadding,
                            itemCount: editableProducts.length,
                            separatorBuilder: (context, index) => SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              final product = editableProducts[index];
                              final currentQty = productQuantities[product.id] ?? product.qty;

                              return EditOrderItem(
                                product: product,
                                quantity: currentQty,
                                onQuantityChanged: (quantity) {
                                  _updateQuantity(product.id, quantity);
                                },
                                onRemove: () {
                                  _showDeleteConfirmation(
                                    context,
                                    product.id,
                                    product.name,
                                  );
                                },
                              );
                            },
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                          SliverToBoxAdapter(
                            child: _buildSuggestedProductsSection(context),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                          SliverToBoxAdapter(
                            child: EditOrderOverview(
                              orderModel: widget.orderModel,
                              editableProducts: editableProducts,
                              productQuantities: productQuantities,
                              isLoading: isLoadingUpdate || isLoadingDelete,
                              onUpdateOrder: () {
                                _handleUpdateOrder(context);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int productId, String productName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(Loc.of(context).remove_product),
        content: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: Loc.of(context).are_you_sure_remove_product,
                style: DefaultTextStyle.of(context).style,
              ),
              TextSpan(
                text: ' $productName',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.redEB,
                ),
              ),
              TextSpan(text: ' ${Loc.of(context).from_the_order}?', style: DefaultTextStyle.of(context).style),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              Loc.of(context).cancel,
              style: TextStyle(color: AppColors.redEB),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              final wasAddedLocally = !widget.orderModel.products.any((p) => p.id == productId);

              if (wasAddedLocally) {
                _removeProduct(productId);
              } else {
                context.read<EditOrderBloc>().deleteOrderProduct(
                      widget.orderModel.orderId,
                      productId,
                    );
              }
            },
            child: Text(
              Loc.of(context).remove,
              style: TextStyle(color: AppColors.grey9E),
            ),
          ),
        ],
      ),
    );
  }

  /// Convert order_details from API response to OrderProductModel list
  List<OrderProductModel> _convertOrderDetailsToProducts(OrderDetailModel orderDetail) {
    if (orderDetail.rawOrderDetails == null || orderDetail.rawOrderDetails!.isEmpty) {
      return [];
    }

    return orderDetail.rawOrderDetails!
        .map((orderDetailItem) {
          final productData = orderDetailItem['product'] as Map<String, dynamic>?;
          if (productData == null) {
            return null;
          }

          final productId = validateInt(orderDetailItem['product_id'] ?? productData['id']);
          final qty = validateInt(orderDetailItem['qty']);

          // Extract image data
          final imageUrlData = productData['image_url'] as Map<String, dynamic>?;
          final imagesData = productData['images'] as List?;

          return OrderProductModel(
            id: productId,
            name: validateString(productData['name']),
            status: validateString(productData['status'] ?? 'active'),
            sku: validateString(productData['sku']),
            description: validateString(productData['description'] ?? ''),
            slug: validateString(productData['slug']),
            price: validateDouble(productData['price']?.toString() ?? '0'),
            formattedPrice: validateString(
              productData['formatted_price'] ?? productData['final_price'] ?? '',
            ),
            finalPrice: validateString(productData['final_price'] ?? ''),
            originalPrice: validateDouble(
              productData['original_price']?.toString() ?? productData['price']?.toString() ?? '0',
            ),
            taxPrice: validateString(productData['tax_price'] ?? '0.00'),
            totalTaxesPercentage: validateDouble(
              productData['total_taxes_percentage']?.toString() ?? '0',
            ),
            imageUrl: imageUrlData != null ? ImageUrl.fromJson(imageUrlData) : null,
            images: imagesData != null
                ? validateJsonList(
                    imagesData.cast<Map<String, dynamic>>(),
                    ImageUrl.fromJson,
                  )
                : [],
            store: null,
            orderDate: validateString(
              orderDetailItem['created_at'] ?? orderDetail.createdAt,
            ),
            isOffer: validateBool(productData['is_offer'] ?? false),
            offerQuantity: validateDouble(
              productData['offer_quantity']?.toString() ?? '0',
            ),
            offerPrice: validateString(productData['offer_price'] ?? ''),
            offerDescription: validateString(productData['offer_description'] ?? ''),
            qty: qty,
          );
        })
        .whereType<OrderProductModel>()
        .toList();
  }

  /// Build suggested products section with custom add method
  Widget _buildSuggestedProductsSection(BuildContext context) {
    return BlocProvider(
      create: (context) => di<ProductsBloc>()..getTopRequestedProducts(),
      child: BlocSelector<ProductsBloc, ProductsState, AllTopRequestedProductsDataState>(
        selector: (state) => state.topRequestedProductsDataState,
        builder: (ctx, state) {
          final list = state.data;
          if (list.isEmpty && !state.loadingState.loading) {
            return const SizedBox();
          }
          if (state.loadingState.loading) {
            return SizedBox(
              height: ProductItemWithAddButton.gridDelegate.mainAxisExtent ?? 0,
              child: const Center(child: CircularLoadingWidget()),
            );
          }
          return SectionLabel(
            label: Loc.of(context).more_suggestions,
            labelPadding: SpacingTheme.of(context).pagePadding,
            onSeeMorePressed: () {
              Nav.products.push(
                ctx,
                args: ProductsPageParams(
                  title: Loc.of(context).more_suggestions,
                  models: list,
                ),
              );
            },
            child: HorizontalListView(
              padding: SpacingTheme.of(context).pagePadding,
              itemCount: list.length,
              height: ProductItemWithAddButton.gridDelegate.mainAxisExtent!,
              separatorBuilder: (ctx, index) => SizedBox(
                width: ProductItemWithAddButton.gridDelegate.crossAxisSpacing,
              ),
              itemBuilder: (ctx, index) => ProductItemWithAddButton(
                apiModel: list[index],
                afterProductAdded: () {
                  // Refresh order details after adding product
                  // context.read<EditOrderBloc>().getOrderDetails(widget.orderModel.orderId);
                },
                addProductMethod: () {
                  _addProductToOrder(context, list[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  /// Add a product to the order
  void _addProductToOrder(BuildContext context, ProductModelApi model) {
    final productId = int.tryParse(model.id) ?? 0;
    if (productId == 0) return;

    final updatedProducts = List<OrderProductModel>.from(_editableProductsNotifier.value);
    final updatedQuantities = Map<int, int>.from(_productQuantitiesNotifier.value);
    final existingProductIndex = updatedProducts.indexWhere((product) => product.id == productId);

    if (existingProductIndex != -1) {
      updatedQuantities[productId] = (updatedQuantities[productId] ?? updatedProducts[existingProductIndex].qty) + 1;
    } else {
      updatedProducts.add(
        OrderProductModel(
          id: productId,
          name: model.name,
          qty: 1,
          description: model.description,
          status: '',
          sku: model.sku,
          slug: model.slug,
          price: model.price,
          formattedPrice: model.formattedPrice,
          finalPrice: model.final_price,
          originalPrice: model.original_price,
          taxPrice: model.tax_price,
          totalTaxesPercentage: double.tryParse(model.tax_price) ?? 0.0,
          imageUrl: ImageUrl(name: model.name, url: model.imageUrl ?? ''),
          images: model.images.map((img) => ImageUrl(name: model.name, url: img.url)).toList(),
          store: null,
          orderDate: '',
          isOffer: false,
          offerQuantity: 0.0,
          offerPrice: '',
          offerDescription: '',
        ),
      );
      updatedQuantities[productId] = 1;
    }

    _editableProductsNotifier.value = updatedProducts;
    _productQuantitiesNotifier.value = updatedQuantities;
  }

  void _handleUpdateOrder(BuildContext context) {
    // Build products list for update
    final products = _editableProducts
        .map(
          (p) => UpdateOrderProductParams(
            id: p.id,
            qty: _productQuantities[p.id] ?? p.qty,
          ),
        )
        .toList();

    // Create update params
    final updateParams = UpdateOrderParams(
      description: description,
      address: address,
      products: products,
      paymentMethod: orderDetail?.payment?.method,
    );

    // Call update order
    context.read<EditOrderBloc>().updateOrderDetails(
          widget.orderModel.orderId,
          updateParams,
        );
  }

  void _applyOrderDetail(OrderDetailModel detail) {
    orderDetail = detail;
    description = detail.description;
    address = detail.address;

    if (detail.rawOrderDetails != null && detail.rawOrderDetails!.isNotEmpty) {
      final updatedProducts =
          _convertOrderDetailsToProducts(detail).where((product) => !product.isOffer && !product.isFreeOffer).toList();
      _editableProductsNotifier.value = updatedProducts;
      _productQuantitiesNotifier.value = {
        for (final product in updatedProducts) product.id: product.qty,
      };
      return;
    }

    if (detail.products.isNotEmpty) {
      final responseQuantities = {
        for (final product in detail.products) product.id: product.qty,
      };
      final filteredProducts =
          _editableProducts.where((product) => responseQuantities.containsKey(product.id)).toList();
      _editableProductsNotifier.value = filteredProducts;
      _productQuantitiesNotifier.value = {
        for (final product in filteredProducts) product.id: responseQuantities[product.id] ?? product.qty,
      };
      return;
    }

    _editableProductsNotifier.value = [];
    _productQuantitiesNotifier.value = {};
  }

  void _updateQuantity(int productId, int quantity) {
    final updated = Map<int, int>.from(_productQuantities);
    updated[productId] = quantity;
    _productQuantitiesNotifier.value = updated;
  }

  void _removeProduct(int productId) {
    final updatedProducts = List<OrderProductModel>.from(_editableProducts)..removeWhere((p) => p.id == productId);
    final updatedQuantities = Map<int, int>.from(_productQuantities)..remove(productId);
    _editableProductsNotifier.value = updatedProducts;
    _productQuantitiesNotifier.value = updatedQuantities;
  }
}
