import 'package:test_vibe/modules/app/spinners/bloc/spinners_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../spinners/models/spinner_reward_model.dart';

class SpinnerRewardSheetParams extends Equatable {
  final SpinnersBloc bloc;
  final SpinnerRewardResult result;

  const SpinnerRewardSheetParams({
    required this.bloc,
    required this.result,
  });

  @override
  List<Object?> get props => [
        bloc,
        result,
      ];
}
