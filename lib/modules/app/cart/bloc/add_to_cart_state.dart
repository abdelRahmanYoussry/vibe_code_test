import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/states/loading_state.dart';
import '../models/add_to_cart_model.dart';

class AddToCartState extends Equatable {
  final AddCommentToProductState addCommentToProductState;
  final AddToCartDataState addToCartDataState;
  final GetFromCartDataState getFromCartDataState;
  final UpdateCartDataState updateCartDataState;
  final RemoveItemFromCartState removeItemFromCartState;


  copyWith({
    AddCommentToProductState? addCommentToProductState,
    AddToCartDataState? addToCartDataState,
    GetFromCartDataState? getFromCartDataState,
    UpdateCartDataState? updateCartDataState,
    RemoveItemFromCartState? removeItemFromCartState,
  }) {
    return AddToCartState(
      addCommentToProductState: addCommentToProductState ?? this.addCommentToProductState,
      addToCartDataState: addToCartDataState ?? this.addToCartDataState,
      getFromCartDataState: getFromCartDataState ?? this.getFromCartDataState,
      updateCartDataState: updateCartDataState ?? this.updateCartDataState,
      removeItemFromCartState: removeItemFromCartState ?? this.removeItemFromCartState,
    );
  }

  const AddToCartState({
    this.addCommentToProductState = const AddCommentToProductState(),
    this.addToCartDataState = const AddToCartDataState(),
    this.getFromCartDataState = const GetFromCartDataState(),
    this.updateCartDataState = const UpdateCartDataState(),
    this.removeItemFromCartState = const RemoveItemFromCartState(),

  });

  @override
  List<Object?> get props => [
        addCommentToProductState,
        addToCartDataState,
        getFromCartDataState,
        updateCartDataState,
        removeItemFromCartState,
      ];
}

class AddCommentToProductState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const AddCommentToProductState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  AddCommentToProductState asLoading() => const AddCommentToProductState(
        loadingState: LoadingState.loading(),
      );

  AddCommentToProductState asLoadingSuccess({
    bool? success,
   required GlobalResponseModel data,
  }) =>
      AddCommentToProductState(success: success, data: data);

  AddCommentToProductState asLoadingFailed(String error) => AddCommentToProductState(
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


class AddToCartDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final AddToCartResponseModel? data;

  const AddToCartDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  AddToCartDataState asLoading() => const AddToCartDataState(
        loadingState: LoadingState.loading(),
      );

  AddToCartDataState asLoadingSuccess({
    bool? success,
   required AddToCartResponseModel data,
  }) =>
      AddToCartDataState(success: success, data: data);

  AddToCartDataState asLoadingFailed(String error) => AddToCartDataState(
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


class GetFromCartDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final AddToCartResponseModel? data;

  const GetFromCartDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  GetFromCartDataState asLoading() => const GetFromCartDataState(
        loadingState: LoadingState.loading(),
      );

  GetFromCartDataState asLoadingSuccess({
    bool? success,
   required AddToCartResponseModel data,
  }) =>
      GetFromCartDataState(success: success, data: data);

  GetFromCartDataState asLoadingFailed(String error) => GetFromCartDataState(
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



class UpdateCartDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final AddToCartResponseModel? data;

  const UpdateCartDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  UpdateCartDataState asLoading() => const UpdateCartDataState(
    loadingState: LoadingState.loading(),
  );

  UpdateCartDataState asLoadingSuccess({
    bool? success,
    required AddToCartResponseModel data,
  }) =>
      UpdateCartDataState(success: success, data: data);

  UpdateCartDataState asLoadingFailed(String error) => UpdateCartDataState(
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


class RemoveItemFromCartState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const RemoveItemFromCartState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  RemoveItemFromCartState asLoading() => const RemoveItemFromCartState(
    loadingState: LoadingState.loading(),
  );

  RemoveItemFromCartState asLoadingSuccess({
    bool? success,
    required GlobalResponseModel data,
  }) =>
      RemoveItemFromCartState(success: success, data: data);

  RemoveItemFromCartState asLoadingFailed(String error) => RemoveItemFromCartState(
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

