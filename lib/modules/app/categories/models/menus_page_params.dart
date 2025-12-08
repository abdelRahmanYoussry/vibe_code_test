import 'package:test_vibe/modules/app/categories/bloc/categories_bloc.dart';
import 'package:equatable/equatable.dart';


class MenusPageParams extends Equatable {
  final String title;
  final CategoriesBloc bloc;

  const MenusPageParams({required this.title, required this.bloc});

  @override
  List<Object?> get props => [
        title,
        bloc,
      ];
}
