import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double horizontalPadding; // Added parameter for horizontal padding

  const Custombutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.horizontalPadding = 100.0, // Default value set to 100
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFCC300),
            padding: EdgeInsets.symmetric(
                vertical: 5, horizontal: horizontalPadding),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: -1),
        ));
  }
}
