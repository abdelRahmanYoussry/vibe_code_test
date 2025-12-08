import 'package:equatable/equatable.dart';

class SpinnerBuyOneGetOnePageParams extends Equatable {
  final String title;
  final String type;
 final String rewardId;
  const SpinnerBuyOneGetOnePageParams({required this.title, required this.type, required this.rewardId});

  @override
  List<Object?> get props => [
        title,
        type,
        rewardId,
      ];
}
