import 'package:flutter/material.dart';

class AddFoodCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const AddFoodCustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(text),
    );
  }
}
