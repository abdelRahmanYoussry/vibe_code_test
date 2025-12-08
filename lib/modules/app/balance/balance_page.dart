import 'package:country_picker/country_picker.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import '../../../core/di/di.dart';
import '../../../core/theme/constants/app_colors.dart';
import '../../../core/utils/constants.dart';
import '../../../core/widgets/amount_field.dart';
import '../../../core/widgets/fields/email_phone_field.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../core/widgets/snack_bar/snack_bar.dart';
import '../points/bloc/points_bloc.dart';
import '../points/bloc/points_state.dart';
import '../points/models/point_model_new.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final ValueNotifier<String?> selectedPaymentMethodNotifier = ValueNotifier<String?>('visa_5246');
  final TextEditingController contactController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  late final ValueNotifier<Country> countryNotifier;
  final ValueNotifier<bool> isFormValidNotifier = ValueNotifier<bool>(false);
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    countryNotifier = ValueNotifier(kDefaultCountry);
    contactController.addListener(_updateFormValidity);
    amountController.addListener(_updateFormValidity);
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _updateFormValidity() {
    isFormValidNotifier.value = amountController.text.isNotEmpty && contactController.text.isNotEmpty;
  }

  @override
  void dispose() {
    contactController.dispose();
    amountController.dispose();
    selectedPaymentMethodNotifier.dispose();
    countryNotifier.dispose();
    isFormValidNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<PointsBloc>()..getHistoryPoints(isFiltered: false),
      child: BlocListener<PointsBloc, PointsState>(
        listenWhen: (previous, current) => previous.transferPointsState != current.transferPointsState,
        listener: (context, state) {
          if (state.transferPointsState.error != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.transferPointsState.error!,
              isSuccess: false,
              duration: 3,
            );
          } else if (state.transferPointsState.data != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.transferPointsState.data?.message ?? Loc.of(context).transfer_success,
              isSuccess: true,
              duration: 2,
            );
            // Clear the form
            // phoneNumberController.clear();
            amountController.clear();
            // Refresh the points balance
            context.read<PointsBloc>().getHistoryPoints(isFiltered: false);
          }
        },
        child: CustomScaffold(
          appBar: CustomAppbar(
            title: Text(Loc.of(context).balance),
          ),
          body: Padding(
            padding: SpacingTheme.of(context).pagePadding,
            child: ValueListenableBuilder(
              valueListenable: selectedPaymentMethodNotifier,
              builder: (context, value, child) {
                return BlocSelector<PointsBloc, PointsState, GetHistoryPointsState>(
                  selector: (state) {
                    return state.getHistoryPoints;
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: state.loadingState.loading
                                ? const Center(child: CircularLoadingWidget())
                                : GestureDetector(
                                    onTap: () {
                                      Nav.points.push(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.brown33,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white, width: 2),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Icon(Icons.attach_money_outlined, color: Colors.white, size: 32.w),
                                          ),
                                          SizedBox(width: 16.w),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Loc.of(context).balance,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                'AED ${state.data?.totalPoints.toString()}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${state.data?.conversionText}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                          SliverToBoxAdapter(
                            child:
                            state.loadingState.loading
                                ? const Center(child: SizedBox.shrink()):
                            InkWell(
                              onTap: () {
                                Nav.recentlyTransaction.push(context, args: _flattenHistory(state.data!.history));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Loc.of(context).recently_transactions,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(CupertinoIcons.right_chevron),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                          SliverToBoxAdapter(
                            child: Text(
                              Loc.of(context).transfer_to,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                          SliverToBoxAdapter(
                            child: EmailOrPhoneField(
                              controller: contactController,
                              textInputAction: TextInputAction.next,
                              onCountryPicked: (value) => countryNotifier.value = value,
                              countryNotifier: countryNotifier ,
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                          SliverToBoxAdapter(
                            child: AmountField(
                              controller: amountController,
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                          // // Payment Transfer Section
                          // SliverToBoxAdapter(
                          //   child: Text(
                          //     Loc.of(context).payment_transfer,
                          //     style: TextStyle(
                          //       fontSize: 16.sp,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   ),
                          // ),
                          //
                          // SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                          //
                          // // VISA Card Payment Option
                          // SliverToBoxAdapter(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(color: AppColors.greyD9, width: 1),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: RadioListTile<String>(
                          //       value: 'visa_5246',
                          //       groupValue: selectedPaymentMethodNotifier.value,
                          //       contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                          //       title: Row(
                          //         children: [
                          //           Text(
                          //             'VISA',
                          //             style: TextStyle(
                          //               color: Colors.blue,
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 18.sp,
                          //             ),
                          //           ),
                          //           SizedBox(width: 8.w),
                          //           Text(
                          //             '**** **** **** 5246',
                          //             style: TextStyle(
                          //               fontSize: 16.sp,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       controlAffinity: ListTileControlAffinity.trailing,
                          //       onChanged: (value) {
                          //         selectedPaymentMethodNotifier.value = value;
                          //       },
                          //     ),
                          //   ),
                          // ),
                          //
                          // SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                          //
                          // // Apple Pay Option
                          // SliverToBoxAdapter(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(color: AppColors.greyD9, width: 1),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: RadioListTile<String>(
                          //       value: 'apple_pay',
                          //       groupValue: selectedPaymentMethodNotifier.value,
                          //       contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                          //       title: Row(
                          //         children: [
                          //           Icon(Icons.apple, size: 24.w),
                          //           SizedBox(width: 8.w),
                          //           Text(
                          //             'Apple Pay',
                          //             style: TextStyle(fontSize: 16.sp),
                          //           ),
                          //         ],
                          //       ),
                          //       controlAffinity: ListTileControlAffinity.trailing,
                          //       onChanged: (value) {
                          //         selectedPaymentMethodNotifier.value = value;
                          //       },
                          //     ),
                          //   ),
                          // ),
                          //
                          // SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                          //
                          // // Google Pay Option
                          // SliverToBoxAdapter(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(color: AppColors.greyD9, width: 1),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: RadioListTile<String>(
                          //       value: 'google_pay',
                          //       groupValue: selectedPaymentMethodNotifier.value,
                          //       contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                          //       title: Row(
                          //         children: [
                          //           Pic(Assets.images.google.path, size: 24.w),
                          //           SizedBox(width: 8.w),
                          //           Text(
                          //             'Google Pay',
                          //             style: TextStyle(fontSize: 16.sp),
                          //           ),
                          //         ],
                          //       ),
                          //       controlAffinity: ListTileControlAffinity.trailing,
                          //       onChanged: (value) {
                          //         selectedPaymentMethodNotifier.value = value;
                          //       },
                          //     ),
                          //   ),
                          // ),
                          SliverToBoxAdapter(child: SizedBox(height: 48.h)),
                          SliverToBoxAdapter(
                            child: ValueListenableBuilder<bool>(
                              valueListenable: isFormValidNotifier,
                              builder: (context, isValid, child) {
                                return BlocSelector<PointsBloc, PointsState, TransferPointsState>(
                                  selector: (state) {
                                    return state.transferPointsState;
                                  },
                                  builder: (context, state) {
                                    return CustomElevatedButton(
                                      enabled:
                                          amountController.text.isNotEmpty && contactController.text.isNotEmpty,
                                      loading: state.loadingState.loading,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<PointsBloc>().transferPoints(
                                                phone: contactController.text,
                                                amount: amountController.text,
                                              );
                                        }
                                      },
                                      child: Text(Loc.of(context).confirm),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
List<LoyaltyPointEntry> _flattenHistory(Map<String, List<LoyaltyPointEntry>> history) {
  List<LoyaltyPointEntry> flattened = [];

  // Add all entries from all time periods
  for (var entries in history.values) {
    flattened.addAll(entries);
  }

  // Sort by date (most recent first) - assuming date is in a parseable format
  flattened.sort((a, b) => b.date.compareTo(a.date));
    // debugPrint('flattened: $flattened');
  return flattened;
}
