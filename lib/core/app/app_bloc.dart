import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/di.dart';
import '../models/user_model.dart';
import 'app_state.dart';

export 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc._(
      // this.authRepo
      ) : super(const AppState());
  // final AuthRepo authRepo;
  factory AppBloc() {
    if (!di.isRegistered<AppBloc>()) {
      // di.registerSingleton<AppBloc>(AppBloc._(di()));
    }
    return di<AppBloc>();
  }

  @override
  Future<void> close() {
    di.unregister<AppBloc>();
    return super.close();
  }

  loggedIn(UserData user) => emit(state.copyWith(user: user));
  // getUser({bool getNewData = false}) async => await authRepo.getProfile(getNewData: getNewData);
  loggedOut() => emit(state.copyWith(user: null, userNull: true));
}
