import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/controllers/checkllist_controllers.dart';
import 'package:textcodetripland/model/checklist_model/checklist.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_textformfield.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/widgets/custombutton.dart';

class ChecklistAdd extends StatefulWidget {
  final String tripId;
  final Checklist? checklist;
  const ChecklistAdd({super.key, required this.tripId, this.checklist});

  @override
  State<ChecklistAdd> createState() => _ChecklistAddState();
}

class _ChecklistAddState extends State<ChecklistAdd> {
  late TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.checklist != null ? widget.checklist!.name : "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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
                CustomContainer(
                  height: 50,
                  color: Colors.white,
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
    final validations = {
      "Please enter the name": _nameController.text.isEmpty,
      'Name must not contain numbers or emojis':
          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(_nameController.text),
    };
    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg.key),
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }
    }
    final checkedlist = Checklist(
      tripId: widget.tripId,
      name: _nameController.text,
    );
    addChecklist(checkedlist);
    Navigator.pop(context);
  }
}
