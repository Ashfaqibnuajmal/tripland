import 'package:flutter/material.dart';
import 'package:textcodetripland/view/widgets/custom_back_arrow.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final dynamic ctx;
  final bool shouldNavigate;
  final Widget? targetPage;
  final List<Widget>? actions;
  final Widget? leading; // Added leading parameter

  const CustomAppBar({
    super.key,
    required this.title,
    required this.ctx,
    this.shouldNavigate = false,
    this.targetPage,
    this.actions,
    this.leading, // Allow custom leading widget
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title, style: CustomTextStyle.headings),
      centerTitle: true,
      leading: leading ??
          CustomBackButton(
              ctx: ctx, shouldNavigate: shouldNavigate, targetPage: targetPage),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Standard app bar height
}
