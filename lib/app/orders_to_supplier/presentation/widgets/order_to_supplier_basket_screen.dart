import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/clients/presentation/client_screen.dart';
import 'package:payme/app/orders_to_supplier/application/new_order_to_supplier/new_order_to_supplier_provider.dart';
import 'package:payme/app/orders_to_supplier/application/orders_to_supplier/orders_to_supplier_provider.dart';
import 'package:payme/app/products/presentation/new_product/widgets/product_text_field.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/presentation/messages/messenger.dart';
import 'package:payme/core/presentation/messages/show_center_message.dart';

class OrderToSupplierBasketScreen extends ConsumerStatefulWidget {
  const OrderToSupplierBasketScreen({super.key});

  @override
  ConsumerState<OrderToSupplierBasketScreen> createState() =>
      _OrderToSupplierBasketScreenState();
}

class _OrderToSupplierBasketScreenState
    extends ConsumerState<OrderToSupplierBasketScreen> {
  TextEditingController supplierController = TextEditingController();

  @override
  void dispose() {
    supplierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sProducts = ref.watch(
      orderToSupplierItemProvider,
    ); // Watch the selected products state
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton.icon(
            label: Text("Очистить корзину"),
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(orderToSupplierItemProvider.notifier).clear();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (sProducts.isEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Корзина пуста!')));
            return;
          }

          if (supplierController.text.isEmpty) {
            showCenteredErrorMessage(context, "Не заполнена поставщик.");
            return;
          }
          ref.read(newOrderToSupplierProvider.notifier).addItem(sProducts);

          ref
              .read(newOrderToSupplierProvider.notifier)
              .createOrderToSupplier()
              .then((value) {
                if (value) {
                  showSuccessMessage(context, "Заявка успешно создана");
                  ref.read(orderToSupplierItemProvider.notifier).clear();
                  Navigator.pop(context);
                } else {
                  showCenteredErrorMessage(
                    context,
                    "Ошибка при создании заказ поставщику",
                  );
                }
              });
        },
        label: const Text('Оформить заказ'),
        icon: const Icon(Icons.check),
      ),
      body: GridTile(
        header: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProductTextField(
                isEnabled: false,
                controller: supplierController,
                labelText: "Поставщик",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    context.push(
                      ClientScreen(
                        onSelected: (selectedClient) {
                          setState(() {
                            supplierController.text = selectedClient.name;
                          });

                          ref
                              .read(newOrderToSupplierProvider.notifier)
                              .setClient(clientModel: selectedClient);
                        },
                      ),
                    );
                  },
                ),
              ),
              Text(
                'Выбранные товары',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),

        child: ListView.separated(
          padding: const EdgeInsets.only(top: 120, bottom: 16, left: 8),
          physics: const BouncingScrollPhysics(),
          separatorBuilder:
              (context, index) => Divider(
                color: Theme.of(context).dividerColor,
                height: 1,
                thickness: 1,
              ),
          itemCount: sProducts.length,
          // Replace with your actual item count
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sProducts.elementAt(index).productName.trim(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Кол-во: ${sProducts.elementAt(index).count}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
