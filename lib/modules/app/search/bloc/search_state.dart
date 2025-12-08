import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:test_vibe/modules/app/search/model/search_recent_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/states/loading_state.dart';
import '../../products/models/product_model_api.dart';

class SearchState extends Equatable {
  final SearchProductsDataState searchProductsDataState;
  final SearchRecentViewState searchRecentViewState;
  final DeleteSearchRecentViewState deleteSearchRecentViewState;


  copyWith({
    SearchProductsDataState? searchProductsDataState,
    SearchRecentViewState? searchRecentViewState,
    DeleteSearchRecentViewState? deleteSearchRecentViewState,
  }) {
    return SearchState(
      searchProductsDataState: searchProductsDataState ?? this.searchProductsDataState,
      searchRecentViewState: searchRecentViewState ?? this.searchRecentViewState,
      deleteSearchRecentViewState: deleteSearchRecentViewState ?? this.deleteSearchRecentViewState,
    );
  }

  const SearchState({
    this.searchProductsDataState = const SearchProductsDataState(),
    this.searchRecentViewState = const SearchRecentViewState(),
    this.deleteSearchRecentViewState = const DeleteSearchRecentViewState(),

  });

  @override
  List<Object?> get props => [
    searchProductsDataState,
    searchRecentViewState,
    deleteSearchRecentViewState,
      ];

}

class SearchProductsDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<ProductModelApi> data;

  const SearchProductsDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data= const [],
  });

  SearchProductsDataState asLoading() => const SearchProductsDataState(
    loadingState: LoadingState.loading(),
  );

  SearchProductsDataState asLoadingSuccess({
    bool? success,
    required List<ProductModelApi> data,
  }) =>
      SearchProductsDataState(success: success, data: data);

  SearchProductsDataState asLoadingFailed(String error) => SearchProductsDataState(
    error: error,
  );

  SearchProductsDataState asReloading() => SearchProductsDataState(
    loadingState: const LoadingState.reloading(),
    data: data,
    error: error,
  );
  SearchProductsDataState asLoadingMoreSuccess(List<ProductModelApi> data) => SearchProductsDataState(
    data: [...this.data, ...data],
  );
  SearchProductsDataState asReloadingSuccess(List<ProductModelApi> data) => SearchProductsDataState(
    data: data,
  );

  SearchProductsDataState asReloadingFailed(String error) => SearchProductsDataState(
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

class SearchRecentViewState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final SearchRecentModel? data;

  const SearchRecentViewState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  SearchRecentViewState asLoading() => const SearchRecentViewState(
    loadingState: LoadingState.loading(),
  );
  SearchRecentViewState asLoadingSuccess({
    bool? success,
    SearchRecentModel? data,
  }) =>
      SearchRecentViewState(success: success, data: data);
  SearchRecentViewState asLoadingFailed(String error) => SearchRecentViewState(
    error: error,
  );
  @override
  List<Object?> get props => [data, loadingState, error, success];
}

class DeleteSearchRecentViewState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const DeleteSearchRecentViewState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  DeleteSearchRecentViewState asLoading() => const DeleteSearchRecentViewState(
    loadingState: LoadingState.loading(),
  );
  DeleteSearchRecentViewState asLoadingSuccess({
    bool? success,
    GlobalResponseModel? data,
  }) =>
      DeleteSearchRecentViewState(success: success, data: data);
  DeleteSearchRecentViewState asLoadingFailed(String error) => DeleteSearchRecentViewState(
    error: error,
  );
  @override
  List<Object?> get props => [data, loadingState, error, success];
}
