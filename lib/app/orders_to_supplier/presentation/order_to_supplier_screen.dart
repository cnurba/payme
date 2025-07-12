import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders_to_supplier/application/order_to_supplier_provider.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier.dart';
import 'package:payme/app/orders_to_supplier/presentation/widgets/order_to_supplier_basket_screen.dart';
import 'package:payme/app/orders_to_supplier/presentation/widgets/order_to_supplier_card.dart';
import 'package:payme/app/reports/presentation/report_menu_screen.dart';
import 'package:payme/core/extensions/route_extension.dart';
import '../application/orders_to_supplier/orders_to_supplier_provider.dart';
import 'widgets/order_to_supplier_list_tile.dart';

class OrderToSupplierScreen extends StatefulWidget {
  const OrderToSupplierScreen({super.key, required this.ordersToSuppliers});

  final List<OrderToSupplier> ordersToSuppliers;

  @override
  State<OrderToSupplierScreen> createState() => _OrderToSupplierScreenState();
}

class _OrderToSupplierScreenState extends State<OrderToSupplierScreen> {
  List<OrderToSupplier> ordersToSuppliers = [];

  @override
  void initState() {
    ordersToSuppliers = [...widget.ordersToSuppliers];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Оформление заказов"),
      actions: [
          IconButton(
            icon: Icon(Icons.repeat_one_rounded),
            onPressed: () {
              context.push(ReportMenuScreen());
            },
          ),
        ],),
      body: Stack(
        children: [
          ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder:
                (context, index) =>
                    Divider(color: theme.dividerColor, height: 1, thickness: 1),
            itemCount: ordersToSuppliers.length,
            itemBuilder: (context, index) {
              final doc = ordersToSuppliers[index];
              return Consumer(
                builder: (context, ref, child) {
                  return OrderToSupplierListTile(
                    onTap: () {
                      ref.read(orderToSupplierItemProvider.notifier).add(doc);
                      ordersToSuppliers.removeAt(index);
                      setState(() {});
                      ref.refresh(orderToSupplierProvider);
                    },
                    doc: doc,
                  );
                },
              );
            },
          ),

          Positioned(
            right: 20,
            bottom: 100,
            child: OrderToSupplierCard(
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
                    return OrderToSupplierBasketScreen();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
