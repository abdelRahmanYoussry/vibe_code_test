import 'package:test_vibe/modules/app/branches/models/branch_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../../core/models/global_model/global_response_model.dart';
import '../../../../../../../../core/utils/states/loading_state.dart';

class BranchesState extends Equatable {
  final AllBranchesDataState allBranchesDataState;
  final AssignBranchToUserState assignBranchToUserState;


  copyWith({
    AllBranchesDataState? allBranchesDataState,
    AssignBranchToUserState? assignBranchToUserState,
  }) {
    return BranchesState(
      allBranchesDataState: allBranchesDataState ?? this.allBranchesDataState,
      assignBranchToUserState: assignBranchToUserState ?? this.assignBranchToUserState,

    );
  }

  const BranchesState({
    this.allBranchesDataState = const AllBranchesDataState(),
    this.assignBranchToUserState = const AssignBranchToUserState(),

  });

  @override
  List<Object?> get props => [
    allBranchesDataState,
    assignBranchToUserState,
      ];

}


class AllBranchesDataState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<BranchModel> data;

  const AllBranchesDataState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data= const [],
  });

  AllBranchesDataState asLoading() => const AllBranchesDataState(
    loadingState: LoadingState.loading(),
  );

  AllBranchesDataState asLoadingSuccess({
    bool? success,
    required List<BranchModel> data,
  }) =>
      AllBranchesDataState(success: success, data: data);

  AllBranchesDataState asLoadingFailed(String error) => AllBranchesDataState(
    error: error,
  );

  AllBranchesDataState asReloading() => AllBranchesDataState(
    loadingState: const LoadingState.reloading(),
    data: data,
    error: error,
  );
  AllBranchesDataState asLoadingMoreSuccess(List<BranchModel> data) => AllBranchesDataState(
    data: [...this.data, ...data],
  );
  AllBranchesDataState asReloadingSuccess(List<BranchModel> data) => AllBranchesDataState(
    data: data,
  );

  AllBranchesDataState asReloadingFailed(String error) => AllBranchesDataState(
    data: data,
    error: error,
  );

  @override
  List<Object?> get props => [
    success,
    loadingState,
    error,
    data,
  ];
}

class AssignBranchToUserState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? assignBranchModel;

  const AssignBranchToUserState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.assignBranchModel,
  });

  AssignBranchToUserState asLoading() => const AssignBranchToUserState(
    loadingState: LoadingState.loading(),
  );

  AssignBranchToUserState asLoadingSuccess({
    bool? success,
    GlobalResponseModel? assignBranchModel,
  }) =>
      AssignBranchToUserState(success: success, assignBranchModel: assignBranchModel);

  AssignBranchToUserState asLoadingFailed(String error) => AssignBranchToUserState(
    error: error,
  );

  @override
  List<Object?> get props => [
    success,
    loadingState,
    error,
  ];
}
