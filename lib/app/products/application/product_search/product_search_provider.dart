import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/products/application/product_search/product_search_state.dart';
import 'package:payme/app/products/domain/models/product.dart';
import 'package:payme/app/products/domain/repositories/i_product_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/injection.dart';

final productSearchProvider =
    StateNotifierProvider<ProductSearchController, ProductSearchState>(
      (ref) => ProductSearchController(getIt<IProductRepository>()),
    );

class ProductSearchController extends StateNotifier<ProductSearchState> {
  /// Creates a NewOrderController with an initial state.
  ProductSearchController(this._api) : super(ProductSearchState.initial());

  final IProductRepository _api;

  Future<void> searchProducts(String searchText) async {
    state = state.copyWith(query: searchText, isLoading: true);
    try {
      final result = await _api.getProductsBySearchText(searchText);
      if (result is ApiResultWithData<List<Product>>) {
        state = state.copyWith(
          products: result.data,
          isLoading: false,
          error: null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to load products',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearSearch() async {
    state = state.copyWith(
      query: '',
      products: [],
      isLoading: false,
      error: null,
    );
  }

  refreshSearch() async{
    try {
      final result = await _api.getProductsBySearchText(state.query);
      if (result is ApiResultWithData<List<Product>>) {
        state = state.copyWith(
          products: result.data,
          isLoading: false,
          error: null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to load products',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
