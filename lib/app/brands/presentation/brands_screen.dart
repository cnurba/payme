import 'package:flutter/material.dart';
import 'package:payme/app/brands/domain/models/brand.dart';
import 'package:payme/app/brands/presentation/brand_card.dart';
import 'package:payme/app/products/presentation/products_screen.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key, required this.brands});

  final List<Brand> brands;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Категории', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket, color: Colors.green),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return BrandCard(
            brand: brand,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProductsScreen(brandId: brand.uuid);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
