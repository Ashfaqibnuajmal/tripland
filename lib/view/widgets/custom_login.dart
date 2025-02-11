import 'package:flutter/material.dart';

class CustomLogin extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final List<BoxShadow>? boxShadow;

  const CustomLogin({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    this.color = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: boxShadow ??
            [
              const BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1),
              ),
            ],
      ),
      child: child,
    );
  }
}
