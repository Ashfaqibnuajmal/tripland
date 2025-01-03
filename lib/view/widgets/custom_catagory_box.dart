import 'package:flutter/material.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class CategoryBox extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CategoryBox({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Light shadow color
              offset: const Offset(2, 4), // Standard, subtle offset
              blurRadius: 4, // Smooth blur for a subtle shadow effect
              spreadRadius: 0, // No spread, just a clean shadow
            ),
          ],
        ),
        child: Text(
          label,
          style: CustomTextStyle.category,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
