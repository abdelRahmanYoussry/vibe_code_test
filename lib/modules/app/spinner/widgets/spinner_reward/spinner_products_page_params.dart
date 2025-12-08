import 'package:equatable/equatable.dart';

class SpinnerProductsPageParams extends Equatable {
  final String title;

  const SpinnerProductsPageParams({required this.title,});

  @override
  List<Object?> get props => [
        title,
      ];
}
