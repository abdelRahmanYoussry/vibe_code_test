// import 'package:test_vibe/core/assets/gen/assets.gen.dart';
// import 'package:test_vibe/core/utils/data_utils.dart';
// import 'package:test_vibe/modules/app/products/models/product_model.dart';
// import 'package:equatable/equatable.dart';
//
// class OfferModel extends Equatable {
//   final String id;
//   final String discount;
//   final String image;
//   final ProductModel? product;
//
//   const OfferModel({
//     required this.id,
//     required this.discount,
//     required this.image,
//     required this.product,
//   });
//
//   OfferModel copyWith({
//     String? id,
//     String? discount,
//     String? image,
//     ProductModel? product,
//   }) {
//     return OfferModel(
//       id: id ?? this.id,
//       discount: discount ?? this.discount,
//       image: image ?? this.image,
//       product: product ?? this.product,
//     );
//   }
//
//   factory OfferModel.fromJson(Map<String, dynamic> json) {
//     return OfferModel(
//       id: validateString(json['id']),
//       discount: validateString(json['discount']),
//       image: validateString(json['image']),
//       product: validateJson(json['product'], ProductModel.fromJson),
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//         id,
//         discount,
//         image,
//         product,
//       ];
// }
//
// final demoOffers = [
//   OfferModel(
//     id: '1',
//     discount: '20',
//     image: Assets.demo.specialOffers1.path,
//     product: demoProducts[0],
//   ),
//   OfferModel(
//     id: '2',
//     discount: '17',
//     image: Assets.demo.specialOffers2.path,
//     product: demoProducts[1],
//   ),
//   OfferModel(
//     id: '3',
//     discount: '4',
//     image: Assets.demo.specialOffers3.path,
//     product: demoProducts[2],
//   ),
//   OfferModel(
//     id: '4',
//     discount: '15',
//     image: Assets.demo.specialOffers4.path,
//     product: demoProducts[3],
//   ),
//   OfferModel(
//     id: '4',
//     discount: '15',
//     image: Assets.demo.specialOffers4.path,
//     product: demoProducts[3],
//   ),
//   OfferModel(
//     id: '5',
//     discount: '30',
//     image: Assets.demo.specialOffers4.path,
//     product: demoProducts[4],
//   ),
// ];
