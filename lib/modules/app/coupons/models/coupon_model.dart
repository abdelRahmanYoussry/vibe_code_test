// import 'package:test_vibe/core/utils/data_utils.dart';
// import 'package:equatable/equatable.dart';
//
// class StaticCouponModel extends Equatable {
//   final String id;
//   final String code;
//   final String desc;
//   final double discountAmount;
//   final String discountLabel;
//   final String expiryDate;
//
//   const StaticCouponModel({
//     required this.id,
//     required this.code,
//     required this.desc,
//     required this.discountAmount,
//     required this.discountLabel,
//     required this.expiryDate,
//   });
//
//   factory StaticCouponModel.fromJson(Map<String, dynamic> json) {
//     return StaticCouponModel(
//       id: validateString(json['id']),
//       code: validateString(json['code']),
//       desc: validateString(json['desc']),
//       discountAmount: validateDouble(json['discountAmount']),
//       discountLabel: validateString(json['discountLabel']),
//       expiryDate: validateString(json['expiryDate']),
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//         id,
//         code,
//         desc,
//         discountAmount,
//         discountLabel,
//         expiryDate,
//       ];
// }
//
// final demoCoupons = [
//   StaticCouponModel(
//     id: '0',
//     code: 'ASCDS4200',
//     desc: 'Order items worth AED 36 more to unlock',
//     discountAmount: 50,
//     discountLabel: 'Get 50% OFF',
//     expiryDate: DateTime.now().toString(),
//   ),
//   StaticCouponModel(
//     id: '1',
//     code: '87DDFJ99',
//     desc: 'Order items worth AED 36 more to unlock',
//     discountAmount: 50,
//     discountLabel: 'Get 50% OFF',
//     expiryDate: DateTime.now().toString(),
//   ),
//   StaticCouponModel(
//     id: '2',
//     code: 'OIRU4800',
//     desc: 'Order items worth AED 36 more to unlock',
//     discountAmount: 50,
//     discountLabel: 'Get 50% OFF',
//     expiryDate: DateTime.now().toString(),
//   ),
// ];
