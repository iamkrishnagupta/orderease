import 'package:flutter/material.dart';

class AddFoodCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const AddFoodCustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
