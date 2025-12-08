import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/modules/app/products/models/product_model.dart';
import 'package:equatable/equatable.dart';

class QrModel extends Equatable {
  final String id;
  final ProductModel? product;
  final String qr;

  const QrModel({
    required this.id,
    required this.product,
    required this.qr,
  });

  factory QrModel.fromJson(Map<String, dynamic> json) {
    return QrModel(
      id: validateString(json['id']),
      product: validateJson(json['product'], ProductModel.fromJson),
      qr: validateString(json['qr']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        product,
        qr,
      ];
}

final demoQrs = [
  QrModel(
    id: '1',
    product: demoProducts[0],
    qr: 'https://quickchart.io/qr?text=hello&size=' '500x500',
  ),
  QrModel(
    id: '2',
    product: demoProducts[1],
    qr: 'https://quickchart.io/qr?text=hello&size=' '500x500',
  ),
  QrModel(
    id: '3',
    product: demoProducts[2],
    qr: 'https://quickchart.io/qr?text=hello&size=' '500x500',
  ),
];
