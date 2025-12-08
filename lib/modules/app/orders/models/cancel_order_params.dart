import 'package:equatable/equatable.dart';

/// Parameters for canceling an order
class CancelOrderParams extends Equatable {
  final String cancellationReason;
  final String? cancellationReasonDescription;

  const CancelOrderParams({
    required this.cancellationReason,
    this.cancellationReasonDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'cancellation_reason': cancellationReason,
      if (cancellationReasonDescription != null)
        'cancellation_reason_description': cancellationReasonDescription,
    };
  }

  @override
  List<Object?> get props =>
      [cancellationReason, cancellationReasonDescription];
}
