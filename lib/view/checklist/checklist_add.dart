import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/checkllist_controllers.dart';
import 'package:textcodetripland/model/checklist_model/checklist.dart';
import 'package:textcodetripland/view/checklist/checklist.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Expenses",
          style: GoogleFonts.anton(fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 25),
        ),
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
                Text(
                  "Name",
                  style: GoogleFonts.anton(color: Colors.white),
                ),
                const Gap(10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Dress or id card",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.black38),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: onAddChecklist,
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCC300),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "SAVE",
                          style: GoogleFonts.anton(
                              color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ),
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
