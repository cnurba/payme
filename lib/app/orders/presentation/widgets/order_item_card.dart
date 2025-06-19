import 'package:flutter/material.dart';
import 'package:payme/app/orders/domain/models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem orderItem;
  final VoidCallback onDelete;
  final VoidCallback? onFavoriteToggle; // Optional
  final Function(int newQuantity) onQuantityChanged;

  const OrderItemCard({
    super.key,
    required this.orderItem,
    required this.onDelete,
    this.onFavoriteToggle,
    required this.onQuantityChanged,
  });

  @override
  _BasketItemCardState createState() => _BasketItemCardState();
}

class _BasketItemCardState extends State<OrderItemCard> {
  late int _quantity;
  bool _isFavorite = false; // Example state for favorite

  @override
  void initState() {
    super.initState();
    _quantity = widget.orderItem.count;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      widget.onQuantityChanged(_quantity);
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      // Or 0 if you allow removing by decrementing to zero
      setState(() {
        _quantity--;
        widget.onQuantityChanged(_quantity);
      });
    } else if (_quantity == 1) {
      // Optional: if quantity is 1 and user presses minus, delete item
      // widget.onDelete();
      // Or simply do nothing, or allow quantity to go to 0 if that's a valid state
      setState(() {
        _quantity--; // Allow going to 0, then perhaps onDelete logic fires if _quantity is 0
        widget.onQuantityChanged(_quantity);
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 12),
                // Middle: Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Distribute space
                    children: [
                      Text(
                        widget.orderItem.product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      // Give some space before the unit price
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Right: Price and Quantity Controls
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Placeholder to maintain alignment if no favorite icon
                    Text(
                      "${widget.orderItem.product.unit}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildQuantityButton(
                          icon: Icons.remove,
                          onPressed: _decrementQuantity,
                          enabled:
                              _quantity >
                              0, // Disable if quantity is 0, or 1 based on logic
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            _quantity.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildQuantityButton(
                          icon: Icons.add,
                          onPressed: _incrementQuantity,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 4,
          left: 4,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.close, color: Colors.red, size: 28),
            onPressed: widget.onDelete,
            tooltip: 'Remove item',
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool enabled = true,
  }) {
    return Material(
      color: enabled ? Colors.purple : Colors.grey[400],
      shape: const CircleBorder(),
      elevation: enabled ? 1 : 0,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(6.0), // Adjusted padding
          child: Icon(
            icon,
            color: Colors.white,
            size: 20, // Adjusted size
          ),
        ),
      ),
    );
  }
}
