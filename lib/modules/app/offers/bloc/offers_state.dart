import 'package:equatable/equatable.dart';
import '../../../../core/utils/states/loading_state.dart';
import '../models/special_offers_model.dart';


class SpecialOffersState extends Equatable {
  final GetAllSpecialOffersState getAllSpecialOffersState;


  copyWith({
    GetAllSpecialOffersState? getAllSpecialOffersState,

  }) {
    return SpecialOffersState(
      getAllSpecialOffersState: getAllSpecialOffersState ?? this.getAllSpecialOffersState,

    );
  }

  const SpecialOffersState({
    this.getAllSpecialOffersState = const GetAllSpecialOffersState(),


  });

  @override
  List<Object?> get props => [
        getAllSpecialOffersState,

      ];
}

class GetAllSpecialOffersState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<FlashSaleModel> data;

  const GetAllSpecialOffersState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  GetAllSpecialOffersState asLoading() => const GetAllSpecialOffersState(
        loadingState: LoadingState.loading(),
      );

  GetAllSpecialOffersState asLoadingSuccess({bool? success, required List<FlashSaleModel> data}) =>
      GetAllSpecialOffersState(success: success, data: data);

  GetAllSpecialOffersState asLoadingFailed(String error) => GetAllSpecialOffersState(
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




