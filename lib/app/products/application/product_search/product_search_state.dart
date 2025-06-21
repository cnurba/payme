import 'package:equatable/equatable.dart';
import 'package:payme/app/products/domain/models/product.dart';

class ProductSearchState extends Equatable {
  final String query;
  final List<Product> products;
  final bool isLoading;
  final String? error;

  const ProductSearchState({
    required this.query,
    required this.products,
    required this.isLoading,
    this.error,
  });

  factory ProductSearchState.initial() {
    return const ProductSearchState(
      query: '',
      products: [],
      isLoading: false,
      error: null,
    );
  }



  ProductSearchState copyWith({
    String? query,
    List<Product>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductSearchState(
      query: query ?? this.query,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, query, products, error];
}
