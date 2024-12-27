import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/expance_controllers.dart';
import 'package:textcodetripland/model/expance_model/expance.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';

import 'package:textcodetripland/view/expance/expance_home.dart';

class ExpanceAdd extends StatefulWidget {
  const ExpanceAdd({
    super.key,
  });

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Add Expenses", style: CustomTextStyle.headings),
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
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                          _date == null
                              ? "21/12/2024"
                              : "${_date!.day}/${_date!.month}/${_date!.year}",
                          style: CustomTextStyle.textStyle5),
                    ),
                  ),
                ),

                // Name Section
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
                      hintText: "Travel or stay",
                      hintStyle: CustomTextStyle.hintText,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  "Price",
                  style: GoogleFonts.roboto(color: Colors.white),
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
                    controller: _priceController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "₹10000",
                      hintStyle: CustomTextStyle.hintText,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
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
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }
    }
    final expance = Expance(
      name: _nameController.text,
      price: _priceController.text,
      date: _date != null
          ? "${_date!.day}/${_date!.month}/${_date!.year}"
          : '', // Formatting the date as string
    );
    addExpance(expance);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ExpanceHome()),
    );
  }
}
