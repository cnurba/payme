import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/floors/domain/models/floor_model.dart';
import 'package:payme/app/floors/presentation/floor_screen.dart';
import 'package:payme/app/objects/presentation/object_screen.dart';
import 'package:payme/app/orders/application/new_orders/new_order_provider.dart';
import 'package:payme/app/orders/presentation/widgets/order_item_card.dart';
import 'package:payme/app/products/presentation/new_product/widgets/product_text_field.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/presentation/buttons/pay_me_check_box.dart';
import 'package:payme/core/presentation/messages/messenger.dart';
import 'package:payme/core/presentation/messages/show_center_message.dart';
import 'package:payme/core/presentation/textforms/date_picker_text_field.dart';

import '../../objects/presentation/block_screen.dart';

class OrderModelScreen extends ConsumerStatefulWidget {
  const OrderModelScreen({super.key});

  @override
  ConsumerState<OrderModelScreen> createState() => _OrderModelScreenState();
}

class _OrderModelScreenState extends ConsumerState<OrderModelScreen> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _objectController = TextEditingController();
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sProduct = ref.watch(newOrderProvider); // Watch t
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.purple),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Оформление заявки',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          createOrder();
          //
        },
        label: const Text('Отправить заявку'),
        icon: const Icon(Icons.check),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Данные доставки',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PayMeCheckBox(
                  onSelect: (p0) {
                    ref
                        .read(newOrderProvider.notifier)
                        .setImportant(isImportant: p0);
                  },
                ),
              ),
              Expanded(
                child: DatePickerTextField(
                  title: "Срок до",
                  onChanged: (p0) {
                    ref.read(newOrderProvider.notifier).setDate(date: p0);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ProductTextField(
            controller: _objectController,
            isEnabled: false,
            labelText: "Объект строительства",
            suffixIcon: IconButton(
              icon: const Icon(Icons.list),
              onPressed: _selectObject,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: ProductTextField(
                  controller: _blockController,
                  isEnabled: false,
                  labelText: "Блок",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: _selectBlock,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ProductTextField(
                  controller: _floorController,
                  isEnabled: false,
                  labelText: "Этаж",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: _selectFloor,
                  ),
                ),
              ),
            ],
          ),

          ProductTextField(
            isEnabled: false,
            controller: _commentController,
            labelText: "Статья расходов",
            suffixIcon: IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {},
            ),
          ),

          ProductTextField(
            labelText: "Комментарий",
            controller: _commentController,
            onChanged: (value) {
              ref.read(newOrderProvider.notifier).setComment(comment: value);
            },
          ),

          ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            //padding: const EdgeInsets.all(8),
            itemCount: sProduct.items.length,
            // Replace with your actual item count
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(sProduct.items[index].product.name),
                subtitle: Text('Количество: ${sProduct.items[index].count}'),
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text("${index + 1}"),
                ),
              );
            },
          ),
          Divider(color: Colors.green, height: 20, thickness: 2),
          SizedBox(height: 8),
          Text(
            'Количество строк в заявке:  ${sProduct.items.length}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  void _selectFloor() {
    context.push(
      FloorScreen(
        onFloorSelected: (floor) {
          _floorController.text = floor.name;
          ref.read(newOrderProvider.notifier).setFloor(floor);
        },
      ),
    );
  }

  void _selectObject() {
    context.push(
      ObjectScreen(
        onObjectSelected: (object) {
          _objectController.text = object.name;
          ref.read(newOrderProvider.notifier).setObject(object);
        },
      ),
    );
  }

  void _selectBlock() {
    final object = ref.read(newOrderProvider).object;
    if (object.uuid.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Сначала выберите объект')));
      return;
    }

    context.push(
      BlockScreen(
        object: object,
        onBlockSelected: (block) {
          _blockController.text = block.name;
          ref.read(newOrderProvider.notifier).setBlock(block);
        },
      ),
    );
  }

  void createOrder() async{
    final order = ref.read(newOrderProvider);

    if (order.object.uuid.isEmpty) {
       showCenteredErrorMessage(context, "Выберите объект");
      return;
    }
    if (order.items.isEmpty) {
      showCenteredErrorMessage(context, "Пустой список товаров! выберите товары");
      return;
    }

    ref.read(newOrderProvider.notifier).createOrder().then((value) {
      if (value) {
        showSuccessMessage(context, "Заявка успешно создана");

        Navigator.pop(context);

      } else {
        showCenteredErrorMessage(context, "Ошибка при создании заявки");
      }
    });

  }
}
