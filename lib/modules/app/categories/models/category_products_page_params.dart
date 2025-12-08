import 'package:equatable/equatable.dart';


class CategoryProductsPageParams extends Equatable {
  final String title;
  // final CategoriesBloc bloc;
  final int categoryId;

  const CategoryProductsPageParams({
    required this.title,
    // required this.bloc,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
        title,
        // bloc,
        categoryId,
      ];
}
