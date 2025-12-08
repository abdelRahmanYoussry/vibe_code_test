import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_state.dart';

class RootBloc extends Cubit<RootState> {
  static RootBloc of(context) => BlocProvider.of(context);

  RootBloc() : super(const RootState(currentIndex: RootIndex.home));

  void changePage(RootIndex index) {
    emit(state.copyWith(currentIndex: index));
  }

  void resetToHome() {
    emit(state.copyWith(currentIndex: RootIndex.home));
  }
}
