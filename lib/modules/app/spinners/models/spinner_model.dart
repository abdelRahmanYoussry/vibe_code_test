// import 'package:test_vibe/core/utils/data_utils.dart';
// import 'package:equatable/equatable.dart';
//
// class SpinnerModel extends Equatable {
//   final String id;
//   final String title;
//   final String desc;
//   final String label;
//   final String date;
//   final String duration;
//   final bool available;
//   final List<SpinnerItemModel> items;
//
//   const SpinnerModel({
//     required this.id,
//     required this.title,
//     required this.desc,
//     required this.label,
//     required this.date,
//     required this.duration,
//     required this.available,
//     required this.items,
//   });
//
//   factory SpinnerModel.fromJson(Map<String, dynamic> json) => SpinnerModel(
//         id: validateString(json['id']),
//         title: validateString(json['title']),
//         desc: validateString(json['desc']),
//         label: validateString(json['label']),
//         date: validateString(json['date']),
//         duration: validateString(json['duration']),
//         available: isTrue(json['available']),
//         items: validateJsonList(json['items'], SpinnerItemModel.fromJson),
//       );
//
//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         desc,
//         label,
//         date,
//         duration,
//         available,
//         items,
//       ];
// }
//
// class SpinnerItemModel extends Equatable {
//   final String id;
//   final String title;
//   final String desc;
//
//   const SpinnerItemModel({
//     required this.id,
//     required this.title,
//     required this.desc,
//   });
//
//   factory SpinnerItemModel.fromJson(Map<String, dynamic> json) => SpinnerItemModel(
//         id: validateString(json['id']),
//         title: validateString(json['title']),
//         desc: validateString(json['desc']),
//       );
//
//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         desc,
//       ];
// }
//
// final demoSpinnerItems = [
//   SpinnerItemModel(
//     id: '1',
//     title: '50%',
//     desc: '50% discount on your next order',
//   ),
//   SpinnerItemModel(
//     id: '2',
//     title: 'Claro Moon',
//     desc: 'a cup of Claro Moon',
//   ),
//   SpinnerItemModel(
//     id: '3',
//     title: 'Crème Matcha',
//     desc: 'a cup of Crème Matcha',
//   ),
//   SpinnerItemModel(
//     id: '4',
//     title: 'Hot Choco-Laro',
//     desc: 'a cup of Hot Choco-Laro',
//   ),
//   SpinnerItemModel(
//     id: '5',
//     title: 'Little Matcha',
//     desc: 'a cup of Little Matcha',
//   ),
//   SpinnerItemModel(
//     id: '6',
//     title: 'Matcha Latte',
//     desc: 'a cup of Matcha Latte',
//   ),
//   SpinnerItemModel(
//     id: '7',
//     title: 'Claro Kinder',
//     desc: 'a cup of Claro Kinder',
//   ),
//   SpinnerItemModel(
//     id: '8',
//     title: '20%',
//     desc: '20% discount on your next order',
//   ),
//   SpinnerItemModel(
//     id: '9',
//     title: 'Coconut Cake',
//     desc: 'a cup of Coconut Cake',
//   ),
//   SpinnerItemModel(
//     id: '10',
//     title: 'Cream Caramel',
//     desc: 'a cup of Cream Caramel',
//   ),
//   SpinnerItemModel(
//     id: '11',
//     title: 'Hazelnut Crunch',
//     desc: 'a cup of Hazelnut Crunch',
//   ),
//   SpinnerItemModel(
//     id: '12',
//     title: 'Acai Smoothie',
//     desc: 'a cup of Acai Smoothie',
//   ),
// ];
//
// final demoSpinners = [
//   SpinnerModel(
//     id: '1',
//     title: 'Spin & Win',
//     desc: 'Unlock Surprises, Discounts & Free Drinks!',
//     label: 'Exclusive Deal of the Day',
//     date: DateTime.now().toString(),
//     duration: Duration.zero.toString(),
//     available: true,
//     items: demoSpinnerItems,
//   ),
//   SpinnerModel(
//     id: '2',
//     title: 'Spin & Win',
//     desc: 'Unlock Surprises, Discounts & Free Drinks!',
//     label: 'Exclusive Deal of the Day',
//     date: DateTime.now().add(Duration(hours: 2, minutes: 30)).toString(),
//     duration: Duration(hours: 2, minutes: 30).toString(),
//     available: false,
//     items: demoSpinnerItems,
//   ),
//   SpinnerModel(
//     id: '3',
//     title: 'Spin & Win',
//     desc: 'Unlock Surprises, Discounts & Free Drinks!',
//     label: 'Exclusive Deal of the Day',
//     date: DateTime.now().add(Duration(hours: 15)).toString(),
//     duration: Duration(hours: 15).toString(),
//     available: false,
//     items: demoSpinnerItems,
//   ),
//   SpinnerModel(
//     id: '4',
//     title: 'Spin & Win',
//     desc: 'Unlock Surprises, Discounts & Free Drinks!',
//     label: 'Exclusive Deal of the Day',
//     date: DateTime.now().add(Duration(hours: 24)).toString(),
//     duration: Duration(hours: 24).toString(),
//     available: false,
//     items: demoSpinnerItems,
//   ),
// ];
