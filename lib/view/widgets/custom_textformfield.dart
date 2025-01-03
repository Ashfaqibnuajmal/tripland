import 'package:flutter/material.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final int? maxLines;
  final EdgeInsetsGeometry contentPadding;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.suffixIcon,
      this.maxLines = 1,
      this.contentPadding = const EdgeInsets.all(10)});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        contentPadding: contentPadding,
        hintStyle: CustomTextStyle.hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
