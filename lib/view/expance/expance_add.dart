import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/expance_controllers.dart';
import 'package:textcodetripland/model/expance_model/expance.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_textformfield.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/widgets/custombutton.dart';

class ExpanceAdd extends StatefulWidget {
  final String tripId;
  final Expance? expance;
  const ExpanceAdd({super.key, this.expance, required this.tripId});

  @override
  State<ExpanceAdd> createState() => _ExpanceAddState();
}

class _ExpanceAddState extends State<ExpanceAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  DateTime? _date;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? selectDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (selectDate != null) {
      setState(() {
        _date = selectDate;
      });
    }
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
            height: 450,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Section
                const SizedBox(height: 20),
                Text(
                  "Date",
                  style: GoogleFonts.anton(color: Colors.white),
                ),
                const Gap(10),
                GestureDetector(
                    onTap: () => _pickDate(context),
                    child: CustomContainer(
                      color: Colors.white,
                      child: Center(
                        child: Text(
                            _date == null
                                ? "Enter the date"
                                : "${_date!.day}/${_date!.month}/${_date!.year}",
                            style: CustomTextStyle.textStyle5),
                      ),
                    )),

                // Name Section
                const SizedBox(height: 20),
                Text(
                  "Iterm name",
                  style: GoogleFonts.anton(color: Colors.white),
                ),
                const Gap(10),
                CustomContainer(
                  color: Colors.white,
                  child: CustomTextFormField(
                    controller: _nameController,
                    hintText: "Travel or stay",
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Price",
                  style: GoogleFonts.anton(color: Colors.white),
                ),
                const Gap(10),

                CustomContainer(
                  color: Colors.white,
                  child: CustomTextFormField(
                    controller: _priceController,
                    hintText: "₹10000",
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Custombutton(
                    text: "ADD EXPANCE",
                    onPressed: onAddExpance,
                    horizontalPadding: 10,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddExpance() async {
    final validations = {
      'Please enter the date': _date == null,
      "Please enter the name": _nameController.text.isEmpty,
      "Please enter the price": _priceController.text.isEmpty
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
    final expance = Expance(
      tripId: widget.tripId,
      name: _nameController.text,
      price: _priceController.text,
      date: _date != null
          ? "${_date!.day}/${_date!.month}/${_date!.year}"
          : '', // Formatting the date as string
    );
    addExpance(expance);
    Navigator.pop(context);
  }
}
