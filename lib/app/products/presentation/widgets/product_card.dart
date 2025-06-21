import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payme/app/products/domain/models/product.dart';
import 'package:payme/core/extensions/numder_extension.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function(int quantity, bool)? onQuantityChanged;

  const ProductCard({super.key, required this.product, this.onQuantityChanged});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;
  bool isCounter = true;

  @override
  void initState() {
    super.initState();
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
    if (widget.onQuantityChanged != null) {
      widget.onQuantityChanged!(quantity, isCounter);
    }
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;

      });
      if (widget.onQuantityChanged != null) {
        widget.onQuantityChanged!(quantity, isCounter);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Контент: цена, текст, плюс
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                SizedBox(
                  height: 40,
                  child: Text(
                    widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                //const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ост: ${widget.product.stock.formatAsNumber()} ${widget.product.unit}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    Row(
                      children: [
                        CircleButton(
                          isAddButton: false,
                          isVisible: quantity > 0,
                          onTap: decrementQuantity,
                        ),

                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Введите количество'),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.right,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        int newQuantity = int.tryParse(value) ?? 0;
                                        setState(() {
                                          quantity = newQuantity;
                                        });
                                        if (widget.onQuantityChanged != null) {
                                          widget.onQuantityChanged!(quantity, false);
                                        }
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            constraints: const BoxConstraints(
                              minWidth: 80,
                              maxWidth: 100,
                              maxHeight: 40,
                              minHeight: 40,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Visibility(
                              visible: quantity > 0,
                              child: Text(
                                '${quantity}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        CircleButton(onTap: incrementQuantity),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    this.onTap,
    this.isAddButton = true,
    this.isVisible = true,
  });

  final VoidCallback? onTap;
  final bool isAddButton;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isAddButton ? Icons.add : Icons.remove,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
