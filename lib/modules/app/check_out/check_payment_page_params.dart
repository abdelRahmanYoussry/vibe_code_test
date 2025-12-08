import 'package:equatable/equatable.dart';

class CheckPaymentPageParams extends Equatable {
  final String paymentUrl;
  final String callbackUrl;
final String orderId;

  const CheckPaymentPageParams({required this.paymentUrl, required this.callbackUrl, required this.orderId});

  @override
  List<Object?> get props => [
        paymentUrl,
        callbackUrl,
        orderId,
      ];
}
