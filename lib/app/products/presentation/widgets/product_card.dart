import 'package:flutter/material.dart';
import 'package:payme/app/products/domain/models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function(int quantity)? onQuantityChanged;

  const ProductCard({super.key, required this.product, this.onQuantityChanged});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
    if (widget.onQuantityChanged != null) {
      widget.onQuantityChanged!(quantity);
    }
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
      if (widget.onQuantityChanged != null) {
        widget.onQuantityChanged!(quantity);
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                      'Остаток: ${widget.product.stock} ${widget.product.unit}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                   
                    CircleButton(
                      isAddButton: false,
                      isVisible: quantity > 0,
                      onTap: decrementQuantity,
                    ),
                    Visibility(
                      visible: quantity > 0,
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    CircleButton(onTap: incrementQuantity),
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
