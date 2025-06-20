import 'package:flutter/material.dart';

class OrderTextField extends StatelessWidget {
  const OrderTextField({super.key, required this.controller, required this.labelText, this.suffixIcon, this.isVisible =true, this.isEnabled = true});

  final TextEditingController controller;
  final String labelText;
  final Widget? suffixIcon;
  final bool isVisible;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Visibility(
        visible: isVisible,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: controller,
              enabled: isEnabled,
              decoration: InputDecoration(
                labelText: labelText,
                border: const OutlineInputBorder(),
                disabledBorder: const OutlineInputBorder(),
                suffixIcon: suffixIcon,
              ),
            ),
            suffixIcon??SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
