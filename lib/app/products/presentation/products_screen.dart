import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/domain/models/brand.dart';
import 'package:payme/app/brands/presentation/brand_card.dart';
import 'package:payme/app/orders/application/orders/orders_provider.dart';
import 'package:payme/app/orders/presentation/orders_screen.dart';
import 'package:payme/app/orders/presentation/widgets/order_card.dart';
import 'package:payme/app/products/application/products_by_brand_id.dart';
import 'package:payme/app/products/application/products_future_provider.dart';
import 'package:payme/app/products/domain/models/product.dart';
import 'package:payme/app/products/presentation/new_product/new_product_screen.dart';
import 'package:payme/app/products/presentation/widgets/product_card.dart';
import 'package:payme/core/failure/app_result.dart';

class ProductsScreen extends ConsumerWidget {
  final String? brandId;

  const ProductsScreen({super.key, this.brandId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(productListByBrandIdFutureProvider(brandId));
    return Scaffold(
      appBar: AppBar(
        title: Text('Товары', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height *
                      0.6, // Max 90% of screen
                  minHeight: 200, // Min height of 200
                ),
                builder: (context) {
                  return NewProductScreen(brandUuid: brandId);
                },
              );
            },
          ),
        ],
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: resultAsync.when(
        data: (products) {
          return Stack(
            children: [
              ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
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
              Positioned(
                right: 20,
                bottom: 100,
                child: OrderCard(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      constraints: BoxConstraints(
                        maxHeight:
                            MediaQuery.of(context).size.height *
                            0.9, // Max 90% of screen
                        minHeight: 200, // Min height of 200
                      ),
                      builder: (context) {
                        return OrdersScreen();
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (e, s) => Center(child: Text("$e")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
