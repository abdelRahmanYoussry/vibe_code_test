import 'package:equatable/equatable.dart';

import '../utils/data_utils.dart';

class CurrencyModel extends Equatable {
  final String id;
  final String name;

  const CurrencyModel({
    required this.id,
    required this.name,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

final demoCurrencies = <CurrencyModel>[
  CurrencyModel(id: '1', name: 'AED'),
];
