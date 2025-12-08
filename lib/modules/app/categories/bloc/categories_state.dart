import 'package:test_vibe/modules/app/categories/models/category_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/states/loading_state.dart';
import '../../products/models/product_model_api.dart';
import '../models/sub_category_model.dart';

class CategoriesState extends Equatable {
  final AllCategoriesDataState allCategoriesDataState;
  final AllCategoryProductsDataState allCategoryProductsDataState;
   final AllSubCategoriesDataState allSubCategoriesDataState;
  copyWith({
    AllCategoriesDataState? allCategoriesDataState,
    AllCategoryProductsDataState? allCategoryProductsDataState,
    AllSubCategoriesDataState? allSubCategoriesDataState,
  }) {
    return CategoriesState(
      allCategoriesDataState: allCategoriesDataState ?? this.allCategoriesDataState,
      allCategoryProductsDataState: allCategoryProductsDataState ?? this.allCategoryProductsDataState,
      allSubCategoriesDataState: allSubCategoriesDataState ?? this.allSubCategoriesDataState,
    );
  }

  const CategoriesState({
    this.allCategoriesDataState = const AllCategoriesDataState(),
    this.allCategoryProductsDataState = const AllCategoryProductsDataState(),
    this.allSubCategoriesDataState = const AllSubCategoriesDataState(),
  });

  @override
  List<Object?> get props => [
        allCategoriesDataState,
        allCategoryProductsDataState,
        allSubCategoriesDataState,
      ];

}

class AllCategoriesDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<CategoryModel> data;

  const AllCategoriesDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  AllCategoriesDataState asLoading() => const AllCategoriesDataState(
        loadingState: LoadingState.loading(),
      );

  AllCategoriesDataState asLoadingSuccess({
    bool? success,
    required List<CategoryModel> data,
  }) =>
      AllCategoriesDataState(success: success, data: data);

  AllCategoriesDataState asLoadingFailed(String error) => AllCategoriesDataState(
        error: error,
      );

  AllCategoriesDataState asReloading() => AllCategoriesDataState(
        loadingState: const LoadingState.reloading(),
        data: data,
        error: error,
      );

  AllCategoriesDataState asLoadingMoreSuccess(List<CategoryModel> data) => AllCategoriesDataState(
        data: [...this.data, ...data],
      );

  AllCategoriesDataState asReloadingSuccess(List<CategoryModel> data) => AllCategoriesDataState(
        data: data,
      );

  AllCategoriesDataState asReloadingFailed(String error) => AllCategoriesDataState(
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

class AllCategoryProductsDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<ProductModelApi> data;

  const AllCategoryProductsDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  AllCategoryProductsDataState asLoading() => const AllCategoryProductsDataState(
        loadingState: LoadingState.loading(),
      );

  AllCategoryProductsDataState asLoadingSuccess({
    bool? success,
    required List<ProductModelApi> data,
  }) =>
      AllCategoryProductsDataState(success: success, data: data);

  AllCategoryProductsDataState asLoadingFailed(String error) => AllCategoryProductsDataState(
        error: error,
      );

  AllCategoryProductsDataState asReloading() => AllCategoryProductsDataState(
        loadingState: const LoadingState.reloading(),
        data: data,
        error: error,
      );

  AllCategoryProductsDataState asLoadingMoreSuccess(List<ProductModelApi> data) => AllCategoryProductsDataState(
        data: [...this.data, ...data],
      );

  AllCategoryProductsDataState asReloadingSuccess(List<ProductModelApi> data) => AllCategoryProductsDataState(
        data: data,
      );

  AllCategoryProductsDataState asReloadingFailed(String error) => AllCategoryProductsDataState(
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

class AllSubCategoriesDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<SubCategoryModel> data;

  const AllSubCategoriesDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  AllSubCategoriesDataState asLoading() => const AllSubCategoriesDataState(
        loadingState: LoadingState.loading(),
      );

  AllSubCategoriesDataState asLoadingSuccess({
    bool? success,
    required List<SubCategoryModel> data,
  }) =>
      AllSubCategoriesDataState(success: success, data: data);

  AllSubCategoriesDataState asLoadingFailed(String error) => AllSubCategoriesDataState(
        error: error,
      );

  AllSubCategoriesDataState asReloading() => AllSubCategoriesDataState(
        loadingState: const LoadingState.reloading(),
        data: data,
        error: error,
      );

  AllSubCategoriesDataState asLoadingMoreSuccess(List<SubCategoryModel> data) => AllSubCategoriesDataState(
        data: [...this.data, ...data],
      );

  AllSubCategoriesDataState asReloadingSuccess(List<SubCategoryModel> data) => AllSubCategoriesDataState(
        data: data,
      );

  AllSubCategoriesDataState asReloadingFailed(String error) => AllSubCategoriesDataState(
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
