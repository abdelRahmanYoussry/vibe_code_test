import 'package:equatable/equatable.dart';

class PaymentWebViewParams extends Equatable {
  final String paymentUrl;
  final String callbackUrl;


  const PaymentWebViewParams({required this.paymentUrl, required this.callbackUrl});

  @override
  List<Object?> get props => [
        paymentUrl,
        callbackUrl,
      ];
}
