import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/states/loading_state.dart';
import '../models/coupons_model.dart';
import '../models/final_check_out_model.dart';
import '../models/order_payment_status_modle.dart';

class CheckOutState extends Equatable {
  final GetCouponsState getCouponsState;
  final ValidateCouponState validateCouponState;
  final OrderCheckState orderCheckState;
  final CheckOrderPaymentState checkOrderPaymentState;


  copyWith({
    GetCouponsState? getCouponsState,
    ValidateCouponState? validateCouponState,
    OrderCheckState? orderCheckState,
    CheckOrderPaymentState? checkOrderPaymentState,
  }) {
    return CheckOutState(
      getCouponsState: getCouponsState ?? this.getCouponsState,
      validateCouponState: validateCouponState ?? this.validateCouponState,
      orderCheckState: orderCheckState ?? this.orderCheckState,
      checkOrderPaymentState: checkOrderPaymentState ?? this.checkOrderPaymentState,
    );
  }

  const CheckOutState({
    this.getCouponsState = const GetCouponsState(),
    this.validateCouponState = const ValidateCouponState(),
    this.orderCheckState = const OrderCheckState(),
    this.checkOrderPaymentState = const CheckOrderPaymentState(),
  });

  @override
  List<Object?> get props => [
        getCouponsState,
        validateCouponState,
        orderCheckState,
        checkOrderPaymentState,
      ];
}

class GetCouponsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<CouponModel> data;

  const GetCouponsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  GetCouponsState asLoading() => const GetCouponsState(
        loadingState: LoadingState.loading(),
      );

  GetCouponsState asLoadingSuccess({bool? success, required List<CouponModel> data}) =>
      GetCouponsState(success: success, data: data);

  GetCouponsState asLoadingFailed(String error) => GetCouponsState(
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

class ValidateCouponState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const ValidateCouponState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  ValidateCouponState asLoading() => const ValidateCouponState(
        loadingState: LoadingState.loading(),
      );

  ValidateCouponState asLoadingSuccess({bool? success, required GlobalResponseModel data}) =>
      ValidateCouponState(success: success, data: data);

  ValidateCouponState asLoadingFailed(String error) => ValidateCouponState(
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

class OrderCheckState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final FinalCheckOutResponseModel? data;

  const OrderCheckState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  OrderCheckState asLoading() => const OrderCheckState(
        loadingState: LoadingState.loading(),
      );

  OrderCheckState asLoadingSuccess({bool? success, required FinalCheckOutResponseModel data}) =>
      OrderCheckState(success: success, data: data);

  OrderCheckState asLoadingFailed(String error) => OrderCheckState(
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


class CheckOrderPaymentState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final OrderPaymentStatusModel? data;

  const CheckOrderPaymentState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  CheckOrderPaymentState asLoading() => const CheckOrderPaymentState(
    loadingState: LoadingState.loading(),
  );

  CheckOrderPaymentState asLoadingSuccess({bool? success, required OrderPaymentStatusModel data}) =>
      CheckOrderPaymentState(success: success, data: data);

  CheckOrderPaymentState asLoadingFailed(String error) => CheckOrderPaymentState(
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
