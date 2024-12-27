import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final dynamic ctx;
  final Color? color;
  final bool
      shouldNavigate; // New parameter to determine if navigation should occur
  final Widget?
      targetPage; // New parameter to define the target page for navigation

  const CustomBackButton({
    super.key,
    this.color,
    required this.ctx,
    this.shouldNavigate = false, // Default to false for pop behavior
    this.targetPage, // Optional target page for navigation
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (shouldNavigate && targetPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage!),
          );
        } else {
          Navigator.pop(ctx);
        }
      },
      icon: const Icon(Icons.arrow_back),
      iconSize: 25,
    );
  }
}
