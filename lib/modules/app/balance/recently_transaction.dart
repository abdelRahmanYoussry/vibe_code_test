import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/empty/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../core/utils/data_utils.dart';
import '../../../core/utils/functions.dart';
import '../points/models/point_model_new.dart';

class RecentlyTransaction extends StatefulWidget {
  const RecentlyTransaction({super.key, required this.model});
  final List<LoyaltyPointEntry>  model;
  @override
  State<RecentlyTransaction> createState() => _RecentlyTransactionState();
}

class _RecentlyTransactionState extends State<RecentlyTransaction> {
  // // Mock data for transactions
  // final List<TransactionModel> transactions = [
  //   TransactionModel(
  //     name: 'Alamin Sarkar',
  //     date: '05 Jan 2024',
  //     amount: 5.25,
  //     isIncome: true,
  //   ),
  //   TransactionModel(
  //     name: 'Alamin Sarkar',
  //     date: '05 Jan 2024',
  //     amount: 5.25,
  //     isIncome: false,
  //   ),
  //   TransactionModel(
  //     name: 'Alamin Sarkar',
  //     date: '05 Jan 2024',
  //     amount: 5.25,
  //     isIncome: true,
  //   ),
  //   TransactionModel(
  //     name: 'Alamin Sarkar',
  //     date: '05 Jan 2024',
  //     amount: 5.25,
  //     isIncome: true,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: Text(Loc.of(context).transfer),
      ),
      body: Padding(
        padding: SpacingTheme.of(context).pagePadding,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
                child: Text(
                  Loc.of(context).recently_transactions,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            widget.model.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: EmptyWidget(),
                    ),
                  )
                :
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: TransactionCard(transaction: widget.model[index]),
                  );
                },
                childCount: widget.model.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionModel {
  final String name;
  final String date;
  final double amount;
  final bool isIncome;

  TransactionModel({
    required this.name,
    required this.date,
    required this.amount,
    required this.isIncome,
  });
}

class TransactionCard extends StatelessWidget {
  final LoyaltyPointEntry transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.action == 'earn' || transaction.action == 'transfer_in';
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Dollar sign icon
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF372826), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.attach_money,
                color: const Color(0xFF372826),
                size: 20.w,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Name and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  validString(transaction.transfer_customer_name)?transaction.transfer_customer_name!:
                  isIncome ? Loc.of(context).earn_points : Loc.of(context).use_points,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  convertUtcToLocalTime(transaction.date,'MMM d, yyyy h:mm a'),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Text(
            '${isIncome ? '+ ' : '- '}AED ${transaction.points}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
