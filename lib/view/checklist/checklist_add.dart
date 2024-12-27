import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/controllers/checkllist_controllers.dart';
import 'package:textcodetripland/model/checklist_model/checklist.dart';
import 'package:textcodetripland/view/checklist/checklist.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';
import 'package:textcodetripland/view/constants/custom_textformfield.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';

class ChecklistAdd extends StatefulWidget {
  const ChecklistAdd({
    super.key,
  });

  @override
  State<ChecklistAdd> createState() => _ChecklistAddState();
}

class _ChecklistAddState extends State<ChecklistAdd> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Add Expenses",
        ctx: context,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(2, 2),
                  blurRadius: 6,
                )
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text("Name", style: CustomTextStyle.textstyle1),
                const Gap(10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomTextFormField(
                    controller: _nameController,
                    hintText: "Dress or ID card",
                  ),
                ),
                const SizedBox(height: 30),
                Custombutton(
                  text: "ADD CHECKLIST",
                  onPressed: onAddChecklist,
                  horizontalPadding: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddChecklist() async {
    final validations = {"Please enter the name": _nameController.text.isEmpty};
    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg.key),
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }
    }
    final checkedlist = Checklist(
      name: _nameController.text,
    );
    addChecklist(checkedlist);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Checklists()),
    );
  }
}
