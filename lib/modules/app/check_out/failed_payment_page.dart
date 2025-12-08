import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import '../../../core/di/di.dart';
import '../../../core/localization/gen/loc.dart';
import '../../../core/theme/constants/app_colors.dart';
import '../../../core/widgets/custom_scaffold.dart';
import 'bloc/check_out_bloc.dart';


class FailedPaymentPage extends StatelessWidget {
  const FailedPaymentPage({
    super.key,
    this.dateTime,
    required this.paymentUrl,
    required this.callbackUrl,
  });

  final DateTime? dateTime;
  final String paymentUrl;
  final String callbackUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CheckOutBloc>(),
      child: CustomScaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Success icon
                        Container(
                          width: 160.w,
                          height: 160.w,
                          decoration:  BoxDecoration(
                            color: AppColors.successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 90.w,
                          ),
                        ),
                        SizedBox(height: 32.h),
                        // Success text
                        Text(
                          Loc.of(context).payment,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        // Date and time
                        Text(
                          _formatDateTime(dateTime ?? DateTime.now()),
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
                // Done button
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
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    // Format: Thu, 15 May, 2:30 PM
    final List<String> weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    final List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
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
