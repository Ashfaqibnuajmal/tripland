import 'package:flutter/material.dart';

// CustomContainer widget with customizable height, width, color, and a flexible child
class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Widget child; // Accept any widget as the child

  // Constructor to pass the required parameters with default height as 50
  const CustomContainer({
    super.key,
    this.height = 50, // Default height set to 50
    this.width = 300,
    this.color = Colors.black12,
    required this.child, // Pass the child widget
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(10), // borderRadius set to 10 as requested
      ),
      child: child, // Use the passed child widget
    );
  }
}
