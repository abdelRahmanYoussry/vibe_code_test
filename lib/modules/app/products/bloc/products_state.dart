import 'package:test_vibe/modules/app/products/models/product_model_api.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/states/loading_state.dart';

class ProductsState extends Equatable {
  final AllTopRequestedProductsDataState topRequestedProductsDataState;
  final AllSignaturesProductsDataState signaturesProductsDataState;
  final GetProductDetailsState productDetailsState;
  final NewlyReleasedProductsDataState newlyReleasedProductsDataState;

  copyWith({
    AllTopRequestedProductsDataState? topRequestedProductsDataState,
    AllSignaturesProductsDataState? signaturesProductsDataState,
    GetProductDetailsState? productDetailsState,
    NewlyReleasedProductsDataState? newlyReleasedProductsDataState,
  }) {
    return ProductsState(
      topRequestedProductsDataState: topRequestedProductsDataState ?? this.topRequestedProductsDataState,
      signaturesProductsDataState: signaturesProductsDataState ?? this.signaturesProductsDataState,
      productDetailsState: productDetailsState ?? this.productDetailsState,
      newlyReleasedProductsDataState: newlyReleasedProductsDataState ?? this.newlyReleasedProductsDataState,
    );
  }

  const ProductsState({
    this.topRequestedProductsDataState = const AllTopRequestedProductsDataState(),
    this.signaturesProductsDataState = const AllSignaturesProductsDataState(),
    this.productDetailsState = const GetProductDetailsState(),
    this.newlyReleasedProductsDataState = const NewlyReleasedProductsDataState(),

  });

  @override
  List<Object?> get props => [
    topRequestedProductsDataState,
    signaturesProductsDataState,
    productDetailsState,
    newlyReleasedProductsDataState,
      ];
}

class AllTopRequestedProductsDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<ProductModelApi> data;

  const AllTopRequestedProductsDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data= const [],
  });

  AllTopRequestedProductsDataState asLoading() => const AllTopRequestedProductsDataState(
        loadingState: LoadingState.loading(),
      );

  AllTopRequestedProductsDataState asLoadingSuccess({
    bool? success,
   required List<ProductModelApi> data,
  }) =>
      AllTopRequestedProductsDataState(success: success, data: data);

  AllTopRequestedProductsDataState asLoadingFailed(String error) => AllTopRequestedProductsDataState(
        error: error,
      );

  AllTopRequestedProductsDataState asReloading() => AllTopRequestedProductsDataState(
    loadingState: const LoadingState.reloading(),
    data: data,
    error: error,
  );
  AllTopRequestedProductsDataState asLoadingMoreSuccess(List<ProductModelApi> data) => AllTopRequestedProductsDataState(
    data: [...this.data, ...data],
  );
  AllTopRequestedProductsDataState asReloadingSuccess(List<ProductModelApi> data) => AllTopRequestedProductsDataState(
    data: data,
  );

  AllTopRequestedProductsDataState asReloadingFailed(String error) => AllTopRequestedProductsDataState(
    data: data,
    error: error,
  );

  @override
  List<Object?> get props => [
        success,
        loadingState,
        error,
        data,
      ];
}


class AllSignaturesProductsDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<ProductModelApi> data;

  const AllSignaturesProductsDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data= const [],
  });

  AllSignaturesProductsDataState asLoading() => const AllSignaturesProductsDataState(
        loadingState: LoadingState.loading(),
      );

  AllSignaturesProductsDataState asLoadingSuccess({
    bool? success,
   required List<ProductModelApi> data,
  }) =>
      AllSignaturesProductsDataState(success: success, data: data);

  AllSignaturesProductsDataState asLoadingFailed(String error) => AllSignaturesProductsDataState(
        error: error,
      );

  AllSignaturesProductsDataState asReloading() => AllSignaturesProductsDataState(
    loadingState: const LoadingState.reloading(),
    data: data,
    error: error,
  );
  AllSignaturesProductsDataState asLoadingMoreSuccess(List<ProductModelApi> data) => AllSignaturesProductsDataState(
    data: [...this.data, ...data],
  );
  AllSignaturesProductsDataState asReloadingSuccess(List<ProductModelApi> data) => AllSignaturesProductsDataState(
    data: data,
  );

  AllSignaturesProductsDataState asReloadingFailed(String error) => AllSignaturesProductsDataState(
    data: data,
    error: error,
  );

  @override
  List<Object?> get props => [
        success,
        loadingState,
        error,
        data,
      ];
}


class GetProductDetailsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final ProductModelApi? data;

  const GetProductDetailsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  GetProductDetailsState asLoading() => const GetProductDetailsState(
    loadingState: LoadingState.loading(),
  );

  GetProductDetailsState asLoadingSuccess({
    bool? success,
    required ProductModelApi data,
  }) =>
      GetProductDetailsState(success: success, data: data);

  GetProductDetailsState asLoadingFailed(String error) => GetProductDetailsState(
    error: error,
  );


  @override
  List<Object?> get props => [
    success,
    loadingState,
    error,
    data,
  ];
}



class NewlyReleasedProductsDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<ProductModelApi> data;

  const NewlyReleasedProductsDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data= const [],
  });

  NewlyReleasedProductsDataState asLoading() => const NewlyReleasedProductsDataState(
    loadingState: LoadingState.loading(),
  );

  NewlyReleasedProductsDataState asLoadingSuccess({
    bool? success,
    required List<ProductModelApi> data,
  }) =>
      NewlyReleasedProductsDataState(success: success, data: data);

  NewlyReleasedProductsDataState asLoadingFailed(String error) => NewlyReleasedProductsDataState(
    error: error,
  );

  NewlyReleasedProductsDataState asReloading() => NewlyReleasedProductsDataState(
    loadingState: const LoadingState.reloading(),
    data: data,
    error: error,
  );
  NewlyReleasedProductsDataState asLoadingMoreSuccess(List<ProductModelApi> data) => NewlyReleasedProductsDataState(
    data: [...this.data, ...data],
  );
  NewlyReleasedProductsDataState asReloadingSuccess(List<ProductModelApi> data) => NewlyReleasedProductsDataState(
    data: data,
  );

  NewlyReleasedProductsDataState asReloadingFailed(String error) => NewlyReleasedProductsDataState(
    data: data,
    error: error,
  );

  @override
  List<Object?> get props => [
    success,
    loadingState,
    error,
    data,
  ];
}
