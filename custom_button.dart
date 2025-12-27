import 'package:flutter/material.dart';

const Color primaryGreen = Color(0xFF4CAF50);

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool isOutlined;
  final double width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = primaryGreen,
    this.textColor = Colors.white,
    this.isOutlined = false,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : color,
          foregroundColor: color, // Warna splash
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isOutlined ? BorderSide(color: color, width: 2) : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isOutlined ? color : textColor,
          ),
        ),
      ),
    );
  }
}