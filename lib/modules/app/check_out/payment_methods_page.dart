import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:test_vibe/modules/app/check_out/bloc/check_out_bloc.dart';
import 'package:test_vibe/modules/app/check_out/bloc/check_out_state.dart';
import 'package:test_vibe/modules/app/check_out/payment_web_view_page_params.dart';
import 'package:test_vibe/modules/app/check_out/widgets/payment_option.dart';
import 'package:test_vibe/modules/app/check_out/widgets/section_title.dart';
import 'package:test_vibe/modules/app/points/bloc/points_bloc.dart';
import 'package:test_vibe/modules/app/points/bloc/points_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/assets/gen/assets.gen.dart';
import '../../../core/di/di.dart';
import '../../../core/localization/gen/loc.dart';
import '../../../core/theme/extensions/spacing_theme.dart';
import '../../../core/widgets/appbars/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final ValueNotifier<String?> selectedMethodNotifier = ValueNotifier<String?>('cash');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CheckOutBloc>(),
      child: BlocListener<CheckOutBloc, CheckOutState>(
        listener: (context, state) {
          if (state.orderCheckState.success != null &&
              state.orderCheckState.success! &&
              state.orderCheckState.data?.isCreditCardPayment() == false) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.orderCheckState.data?.message ?? Loc.of(context).successfully_added('order'),
              isSuccess: true,
              duration: 3,
              onTap: () {},
            );
            Nav.root.replaceAll(context);
          } else if (state.orderCheckState.success != null &&
              state.orderCheckState.success! &&
              state.orderCheckState.data?.isCreditCardPayment() == true) {
            Nav.paymentWebView.push(
              context,
              args: PaymentWebViewParams(
                paymentUrl: state.orderCheckState.data?.payment_url ?? '',
                callbackUrl: state.orderCheckState.data?.callback_url ?? '',
              ),
            );
          } else if (state.orderCheckState.error != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.orderCheckState.error ?? Loc.of(context).something_went_wrong,
              isSuccess: false,
              duration: 3,
              onTap: () {},
            );
          }
        },
        child: CustomScaffold(
          appBar: CustomAppbar(
            title: Text(
              Loc.of(context).payment_methods,
            ),
          ),
          body: Padding(
            padding: SpacingTheme.of(context).pagePadding,
            child: ValueListenableBuilder(
              valueListenable: selectedMethodNotifier,
              builder: (context, value, child) {
                return CustomScrollView(
                  slivers: [
                    SectionTitle(
                      title: Loc.of(context).creditAndDebitCard,
                    ),
                    // AddCreditCardOption(
                    //   label: Loc.of(context).addCard,
                    //   onTap: () {
                    //     Nav.addCreditCard.push(context);
                    //   },
                    //   leading: Pic(Assets.icons.addCreditCard.path, size: 28),
                    // ),
                    PaymentOption(
                      label: Loc.of(context).pay_with_credit_card,
                      value: 'credit',
                      groupValue: selectedMethodNotifier.value,
                      leadingWidget: Pic(Assets.icons.creditCard.path, size: 28),
                      onChanged: (value) {
                        selectedMethodNotifier.value = value;
                      },
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16.h,
                      ),
                    ),
                    // PaymentOption(
                    //   label: '**** **** **** 5248',
                    //   value: 'visa_5248',
                    //   groupValue: selectedMethodNotifier.value,
                    //   onChanged: (value) {
                    //     selectedMethodNotifier.value = value;
                    //   },
                    //   leadingWidget: Text(
                    //     "VISA",
                    //     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: SizedBox(
                    //     height: 16.h,
                    //   ),
                    // ),
                    SectionTitle(
                      title: Loc.of(context).cash,
                    ),
                    PaymentOption(
                      label: 'Payment at the branch',
                      value: 'cash',
                      groupValue: selectedMethodNotifier.value,
                      leadingWidget: Pic(Assets.icons.cash.path, size: 28),
                      onChanged: (value) {
                        selectedMethodNotifier.value = value;
                      },
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16.h,
                      ),
                    ),
                    BlocProvider(
                      create: (context) => di<PointsBloc>()..getUserPoints(),
                      child: BlocBuilder<PointsBloc, PointsState>(
                        builder: (context, state) {
                          final data = state.getPointsState.data;
                          if (data == null && !state.getPointsState.loadingState.loading) {
                            return SliverToBoxAdapter(child: const SizedBox());
                          }

                          if (state.getPointsState.loadingState.loading) {
                            return SliverToBoxAdapter(child: Center(child: LinearProgressIndicator()));
                          }
                          return SectionTitle(
                            title:
                                '${Loc.of(context).wallet} (${Loc.of(context).balance}: ${state.getPointsState.data?.walletBalance} AED )',
                          );
                        },
                      ),
                    ),
                    PaymentOption(
                      label: Loc.of(context).points,
                      value: 'points',
                      leadingWidget: Pic(Assets.icons.points.path, size: 28),
                      groupValue: selectedMethodNotifier.value,
                      onChanged: (value) {
                        selectedMethodNotifier.value = value;
                      },
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16.h,
                      ),
                    ),
                    // SectionTitle(
                    //   title: Loc.of(context).morePaymentOptions,
                    // ),
                    // PaymentOption(
                    //   icon: Icons.apple,
                    //   label: 'Apple Pay',
                    //   value: 'apple_pay',
                    //   groupValue: selectedMethodNotifier.value,
                    //   onChanged: (value) {
                    //     selectedMethodNotifier.value = value;
                    //   },
                    // ),
                    // SliverToBoxAdapter(
                    //   child: SizedBox(
                    //     height: 16.h,
                    //   ),
                    // ),
                    // PaymentOption(
                    //   icon: Icons.g_mobiledata,
                    //   label: 'Google Pay',
                    //   value: 'google_pay',
                    //   groupValue: selectedMethodNotifier.value,
                    //   onChanged: (value) {
                    //     selectedMethodNotifier.value = value;
                    //   },
                    //   leadingWidget: Pic(Assets.images.google.path),
                    // ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: BlocSelector<CheckOutBloc, CheckOutState, OrderCheckState>(
                          selector: (state) {
                            return state.orderCheckState;
                          },
                          builder: (context, state) {
                            return CustomElevatedButton(
                              loading: state.loadingState.loading,
                              onPressed: () {
                                if (selectedMethodNotifier.value == null) return;
                                BlocProvider.of<CheckOutBloc>(context)
                                    .checkOutOrder(paymentType: selectedMethodNotifier.value!);
                              },
                              child: Text(
                                Loc.of(context).confirm,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16.h,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
