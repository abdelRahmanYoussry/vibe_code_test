import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/modules/app/check_out/bloc/check_out_state.dart';
import 'package:test_vibe/modules/app/check_out/payment_web_view_page_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import '../../../core/di/di.dart';
import '../../../core/localization/gen/loc.dart';
import '../../../core/theme/constants/app_colors.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import 'bloc/check_out_bloc.dart';

class CheckPaymentPage extends StatefulWidget {
  const CheckPaymentPage({
    super.key,
    required this.orderId,
    required this.paymentUrl,
    required this.callbackUrl,
  });

  final String orderId;
  final String paymentUrl;
  final String callbackUrl;

  @override
  State<CheckPaymentPage> createState() => _CheckPaymentPageState();
}

class _CheckPaymentPageState extends State<CheckPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CheckOutBloc>()..checkOrderPayStatus(widget.orderId),
      child: BlocListener<CheckOutBloc, CheckOutState>(
        listener: (context, state) {},
        child: CustomScaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: BlocSelector<CheckOutBloc, CheckOutState, CheckOrderPaymentState>(
                selector: (state) {
                  return state.checkOrderPaymentState;
                },
                builder: (context, state) {
                  // Show loading state
                  if (state.loadingState.loading) {
                    return Center(child: CircularLoadingWidget());
                  }

                  // Show error state
                  if (state.error != null) {
                    return _buildErrorUI(state.error!);
                  }

                  // Check payment success/failure based on data.success
                  final bool isPaymentSuccessful = state.data?.data?.success ?? false;

                  if (isPaymentSuccessful) {
                    return _buildSuccessUI(state.data?.data?.message ?? Loc.of(context).your_booking_is_confirmed);
                  } else {
                    return _buildFailureUI(state.data?.data?.message ?? 'Payment not completed');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessUI(String message) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160.w,
                  height: 160.w,
                  decoration: BoxDecoration(
                    color: AppColors.successColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 90.w,
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  _formatDateTime(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey9A,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 32.h),
          child: CustomElevatedButton(
            onPressed: () {
              Nav.root.replaceAll(context);
            },
            child: Text(
              Loc.of(context).done,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFailureUI(String message) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160.w,
                  height: 160.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 90.w,
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  _formatDateTime(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey9A,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: CustomElevatedButton(
            onPressed: () {
              Nav.paymentWebView.push(
                context,
                args: PaymentWebViewParams(
                  paymentUrl: widget.paymentUrl ,
                  callbackUrl: widget.callbackUrl,
                ),
              );
            },
            child: Text(
             Loc.of(context).try_again,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 32.h),
          child: CustomElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.grey9A),
            ),
            onPressed: () {
              Nav.root.replaceAll(context);
            },
            child: Text(
              Loc.of(context).cancel,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorUI(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.w,
            color: Colors.red,
          ),
          SizedBox(height: 16.h),
          Text(
            Loc.of(context).error_While_getting_data,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(Loc.of(context).cancel),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final List<String> weekdays = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
    ];
    final List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    final String weekday = weekdays[dateTime.weekday - 1];
    final String month = months[dateTime.month - 1];
    final String day = dateTime.day.toString();

    final int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$weekday, $day $month, $hour:$minute $period';
  }
}
