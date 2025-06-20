import 'package:flutter/material.dart';
import 'package:payme/app/objects/domain/models/block_model.dart';
import 'package:payme/app/objects/domain/models/object_model.dart';

class BlockScreen extends StatelessWidget {
  const BlockScreen({super.key, required this.object, this.onBlockSelected});

  final ObjectModel object;
  final Function(BlockModel block)? onBlockSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(onBlockSelected == null ? 'Блоки' : 'Выберите блок'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.5,
        ),
        itemCount: object.blocks.length,
        itemBuilder: (context, index) {
          final block = object.blocks[index];
          return GestureDetector(
            onTap: () {
              onBlockSelected?.call(block);
              Navigator.pop(context);
            },
            child: Card(
              elevation: 4,
              shadowColor: Colors.grey,
              surfaceTintColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  block.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
