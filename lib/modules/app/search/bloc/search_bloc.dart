
import 'package:test_vibe/modules/app/products/repo/product_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/repos/lang_repo.dart';
import 'search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.productRepo,
  }) : super(const SearchState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final ProductsRepo productRepo;
  int signaturesProductsPageNumber = 1;
  bool signaturesProductsIsLastPage = false;

  Future<void> getSearchProducts({required String keyWords}) async {
    signaturesProductsPageNumber = 1;
    emit(state.copyWith(searchProductsDataState: state.searchProductsDataState.asLoading()));
    final f = await productRepo.getSearchProductsResult(keyWords);
    f.fold(
      (l) => emit(
        state.copyWith(
          searchProductsDataState: state.searchProductsDataState.asLoadingFailed(l),
        ),
      ),
      (r) {
        signaturesProductsPageNumber = 2;
        if (r.length != 10) {
          signaturesProductsIsLastPage = true;
        } else {
          signaturesProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            searchProductsDataState: state.searchProductsDataState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getSearchRecentView() async {
    emit(state.copyWith(searchRecentViewState: state.searchRecentViewState.asLoading()));
    final f = await productRepo.getSearchRecentView();
    f.fold(
      (l) => emit(
        state.copyWith(
          searchRecentViewState: state.searchRecentViewState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            searchRecentViewState: state.searchRecentViewState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> clearSearchRecentView(int productId) async {
    emit(state.copyWith(deleteSearchRecentViewState: state.deleteSearchRecentViewState.asLoading()));
    final f = await productRepo.deleteRecentView(productId: productId);
    f.fold(
      (l) => emit(
        state.copyWith(
          deleteSearchRecentViewState: state.deleteSearchRecentViewState.asLoadingFailed(l),
        ),
      ),
      (r) async {
        emit(
          state.copyWith(
            deleteSearchRecentViewState: state.deleteSearchRecentViewState.asLoadingSuccess(
              data: r,
              success: true,
            ),
          ),
        );
       await getSearchRecentView();
      },
    );
  }
}
