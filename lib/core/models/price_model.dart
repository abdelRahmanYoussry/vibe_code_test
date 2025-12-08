import 'package:equatable/equatable.dart';

import '../utils/data_utils.dart';
import 'currency_model.dart';

class PriceModel extends Equatable {
  final double value;
  final CurrencyModel? currency;
  final String label;

  const PriceModel({
    required this.value,
    required this.currency,
    required this.label,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
        value: validateDouble(json['value']),
        currency: validateJson(json['currency'], CurrencyModel.fromJson),
        label: validateString(json['label']),
      );

  @override
  List<Object?> get props => [
        value,
        currency,
        label,
      ];
}
