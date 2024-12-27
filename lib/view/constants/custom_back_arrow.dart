import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final dynamic ctx;
  final Color? color;
  const CustomBackButton({
    super.key,
    this.color,
    required this.ctx,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(ctx);
      },
      icon: const Icon(Icons.arrow_back),
      iconSize: 25,
    );
  }
}
