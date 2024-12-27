import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';

class CustomDeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final String title;
  final String message;
  const CustomDeleteDialog({
    super.key,
    required this.onDelete,
    this.title = 'Delete?',
    this.message = 'Are you sure you want to delete this item?',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.report_gmailerrorred_outlined,
              size: 30,
              color: Colors.redAccent,
            ),
            const Gap(10),
            Text(title, style: CustomTextStyle.textstyle8),
            const Gap(10),
            Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel button
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child:
                        const Text('Cancel', style: CustomTextStyle.textStyle7),
                  ),
                ),
                // Delete button
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                    onPressed: () {
                      onDelete();
                      Navigator.pop(context);
                    },
                    child:
                        const Text('Delete', style: CustomTextStyle.textStyle7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
