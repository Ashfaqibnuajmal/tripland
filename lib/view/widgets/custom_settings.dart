import 'package:flutter/material.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const SettingsButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const Spacer(),
            Text(label, style: CustomTextStyle.textStyle5),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
