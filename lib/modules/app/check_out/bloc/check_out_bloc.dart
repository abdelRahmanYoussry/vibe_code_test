import 'package:test_vibe/modules/app/check_out/repo/check_out_repo.dart';
import 'package:test_vibe/modules/app/products/repo/product_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import 'check_out_state.dart';

class CheckOutBloc extends Cubit<CheckOutState> {
  CheckOutBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.productsRepo,
    required this.checkOutRepo,
  }) : super(const CheckOutState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final ProductsRepo productsRepo;
  final CheckOutRepo checkOutRepo;

  Future<void> getCoupons() async {
    emit(state.copyWith(getCouponsState: state.getCouponsState.asLoading()));
    final f = await checkOutRepo.getCoupons();
    f.fold(
      (l) => emit(
        state.copyWith(
          getCouponsState: state.getCouponsState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            getCouponsState: state.getCouponsState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> validateCoupon({required String coupon}) async {
    emit(state.copyWith(validateCouponState: state.validateCouponState.asLoading()));
    final f = await checkOutRepo.validateCoupon(coupon: coupon);
    f.fold(
      (l) => emit(
        state.copyWith(
          validateCouponState: state.validateCouponState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            validateCouponState: state.validateCouponState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },

    );
  }

  Future<void> checkOutOrder({required String paymentType}) async {
    emit(state.copyWith(orderCheckState: state.orderCheckState.asLoading()));
    final f = await checkOutRepo.checkOutOrder(payType: paymentType);
    f.fold(
      (l) => emit(
        state.copyWith(
          orderCheckState: state.orderCheckState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            orderCheckState: state.orderCheckState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> checkOrderPayStatus(String OrderId) async {
    emit(state.copyWith(checkOrderPaymentState: state.checkOrderPaymentState.asLoading()));
    final f = await checkOutRepo.checkOrderStatus(OrderId: OrderId);
    f.fold(
          (l) => emit(
        state.copyWith(
          checkOrderPaymentState: state.checkOrderPaymentState.asLoadingFailed(l),
        ),
      ),
          (r) {
        emit(
          state.copyWith(
            checkOrderPaymentState: state.checkOrderPaymentState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }
}
