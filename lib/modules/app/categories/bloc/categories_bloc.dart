import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import '../repo/categories_repo.dart';
import 'categories_state.dart';

class CategoriesBloc extends Cubit<CategoriesState> {
  CategoriesBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.categoriesRepo,
  }) : super(const CategoriesState());

  final CategoriesRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final CategoriesRepo categoriesRepo;

  int categoryPageNumber = 1;
  bool categoryIsLastPage = false;

  int categoryProductPageNumber = 1;
  bool categoryProductIsLastPage = false;

  int subCategoryPageNumber = 1;
  bool subCategoryIsLastPage = false;

  Future<void> getCategories() async {
    categoryPageNumber = 1;
    emit(state.copyWith(allCategoriesDataState: state.allCategoriesDataState.asLoading()));
    final f = await categoriesRepo.getCategories(categoryPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          allCategoriesDataState: state.allCategoriesDataState.asLoadingFailed(l),
        ),
      ),
      (r) {
        categoryPageNumber = 2;
        if (r.length != 10) {
          categoryIsLastPage = true;
        } else {
          categoryIsLastPage = false;
        }
        emit(
          state.copyWith(
            allCategoriesDataState: state.allCategoriesDataState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreCategories() async {
    if (state.allCategoriesDataState.loadingState.loading ||
        state.allCategoriesDataState.loadingState.reloading ||
        categoryIsLastPage) {
      return;
    }
    emit(state.copyWith(allCategoriesDataState: state.allCategoriesDataState.asReloading()));
    final f = await categoriesRepo.getCategories(categoryPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          allCategoriesDataState: state.allCategoriesDataState.asReloadingFailed(l),
        ),
      ),
      (r) {
        categoryPageNumber += 1;
        if (r.length != 10) {
          categoryIsLastPage = true;
        } else {
          categoryIsLastPage = false;
        }
        emit(
          state.copyWith(
            allCategoriesDataState: state.allCategoriesDataState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }

  Future<void> getCategoryProducts(int id) async {
    categoryProductPageNumber = 1;
    emit(state.copyWith(allCategoryProductsDataState: state.allCategoryProductsDataState.asLoading()));
    final f = await categoriesRepo.getProductsForCategory(id, categoryProductPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          allCategoryProductsDataState: state.allCategoryProductsDataState.asLoadingFailed(l),
        ),
      ),
      (r) {
        categoryProductPageNumber = 2;
        if (r.length != 10) {
          categoryProductIsLastPage = true;
        } else {
          categoryProductIsLastPage = false;
        }
        emit(
          state.copyWith(
            allCategoryProductsDataState: state.allCategoryProductsDataState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreCategoryProducts(int id) async {
    if (state.allCategoryProductsDataState.loadingState.loading ||
        state.allCategoryProductsDataState.loadingState.reloading ||
        categoryProductIsLastPage) {
      return;
    }
    emit(state.copyWith(allCategoryProductsDataState: state.allCategoryProductsDataState.asReloading()));
    final f = await categoriesRepo.getProductsForCategory(id, categoryProductPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          allCategoryProductsDataState: state.allCategoryProductsDataState.asReloadingFailed(l),
        ),
      ),
      (r) {
        categoryProductPageNumber += 1;
        if (r.length != 10) {
          categoryProductIsLastPage = true;
        } else {
          categoryProductIsLastPage = false;
        }
        emit(
          state.copyWith(
            allCategoryProductsDataState: state.allCategoryProductsDataState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }

  Future<void> getSubCategories(int categoryId) async {
    subCategoryPageNumber = 1;
    emit(state.copyWith(allSubCategoriesDataState: state.allSubCategoriesDataState.asLoading()));
    final f = await categoriesRepo.getSubCategories(categoryId, subCategoryPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          allSubCategoriesDataState: state.allSubCategoriesDataState.asLoadingFailed(l),
        ),
      ),
      (r) {
        subCategoryPageNumber = 2;
        if (r.length != 10) {
          subCategoryIsLastPage = true;
        } else {
          subCategoryIsLastPage = false;
        }
        emit(
          state.copyWith(
            allSubCategoriesDataState: state.allSubCategoriesDataState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreSubCategories(int categoryId) async {
    if (state.allSubCategoriesDataState.loadingState.loading ||
        state.allSubCategoriesDataState.loadingState.reloading ||
        subCategoryIsLastPage) {
      return;
    }
    emit(state.copyWith(allSubCategoriesDataState: state.allSubCategoriesDataState.asReloading()));
    final f = await categoriesRepo.getSubCategories(categoryId, subCategoryPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          allSubCategoriesDataState: state.allSubCategoriesDataState.asReloadingFailed(l),
        ),
      ),
      (r) {
        subCategoryPageNumber += 1;
        if (r.length != 10) {
          subCategoryIsLastPage = true;
        } else {
          subCategoryIsLastPage = false;
        }
        emit(
          state.copyWith(
            allSubCategoriesDataState: state.allSubCategoriesDataState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }
}
