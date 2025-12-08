import 'package:equatable/equatable.dart';

class RewardProductsPageParams extends Equatable {
  final String title;

  const RewardProductsPageParams({required this.title});

  @override
  List<Object?> get props => [
        title,
      ];
}
