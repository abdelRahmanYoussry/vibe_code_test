import 'package:test_vibe/modules/app/home/widgets/home_appbar/widgets/my_location_widget/bloc/branches_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../branches/models/branch_model.dart';


class BranchesPageParams extends Equatable {
  final BranchesBloc bloc;
  final BranchModel? selectedBranch;

  const BranchesPageParams({
    required this.bloc,
     this.selectedBranch,
  });

  @override
  List<Object?> get props => [
        selectedBranch,
        bloc,
        selectedBranch,
      ];
}
