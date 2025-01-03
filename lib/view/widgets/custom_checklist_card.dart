import 'package:flutter/material.dart';
import 'package:textcodetripland/view/widgets/custom_showdilog.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class ChecklistItem extends StatelessWidget {
  final int index;
  final Map<int, bool> checkboxStates;
  final dynamic checklist;
  final Function onDelete;

  const ChecklistItem({
    super.key,
    required this.index,
    required this.checklist,
    required this.checkboxStates,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) => CustomDeleteDialog(
            onDelete: () {
              onDelete();
            },
            title: 'Delete checklist?',
            message: "Are you sure you want to delete this checklist item?",
          ),
        );
      },
      child: Card(
        color: Colors.grey[50],
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  checklist.name ?? "NA",
                  style: CustomTextStyle.textStyle4,
                ),
              ),
              Checkbox(
                checkColor: Colors.blueAccent,
                activeColor: Colors.grey[50],
                value: checkboxStates[index] ?? false,
                onChanged: (bool? value) {
                  onDelete(); // Handle checkbox state change here if needed
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
