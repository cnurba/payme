
import 'package:flutter/material.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({
    super.key,
    required this.count,
    required this.onTap,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.countText, required this.bgColor,
  });

  final int count;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;
  final String countText;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor, // зелёный фон
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Левая часть с процентом
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    countText,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // Разделительная пунктирная линия
          Container(
            width: 1,
            height: 80,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 4),
          ),
          // Правая часть
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        description,
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color(0xFF3AC88B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
