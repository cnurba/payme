import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/products/application/product_search/product_search_provider.dart';
import 'package:payme/app/products/domain/models/product.dart';
import 'package:payme/app/products/presentation/widgets/product_card.dart';

import '../../orders/application/orders/orders_provider.dart';

class ProductSearchScreen extends ConsumerWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultState = ref.watch(productSearchProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: SearchTextField(
          onSubmitted: (value) {
            if (value.isEmpty) {
              ref.read(productSearchProvider.notifier).clearSearch();
              return;
            }
            if (value.length < 3) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Введите не менее 3 символов для поиска'),
                ),
              );
              return;
            }
            ref.read(productSearchProvider.notifier).searchProducts(value);
          },
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Colors.white,
            size: 50,
          ),
          onPressed: () {
            ref.read(productSearchProvider.notifier).clearSearch();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(productSearchProvider.notifier).refreshSearch();
        },
        child:
            resultState.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: resultState.products.length,
                  itemBuilder: (context, index) {
                    Product product = resultState.products[index];
                    return ProductCard(
                      product: product,
                      onQuantityChanged: (quantity, isCounter) {
                        ref
                            .read(orderItemProvider.notifier)
                            .addProduct(product, quantity, isCounter);
                      },
                    );
                  },
                ),
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final String hintText;

  const SearchTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onSubmitted,
    this.hintText = 'Поиск...',
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          isDense: true,
          //contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search, size: 30),
            onPressed: () {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(_controller.text);
              }
              setState(() {});
            },
          ),
        ),
        onSubmitted: widget.onSubmitted,
        onChanged: (_) => setState(() {}),

      ),
    );
  }
}
