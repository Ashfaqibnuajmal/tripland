import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class BucketlistAdd extends StatefulWidget {
  const BucketlistAdd({super.key});

  @override
  State<BucketlistAdd> createState() => _BucketlistAddState();
}

class _BucketlistAddState extends State<BucketlistAdd> {
  String? selectedOption = "Beach Trip";

  final List<String> options = [
    "Beach Trip",
    "Mountain Hike",
    "City Tour",
    "Camping Adventure",
    "Road Trip",
    "Wildlife Safari",
    "Cultural Visit",
    "Food Tasting Tour",
    "Family Vacation",
    "Weekend Getaway"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Add Bucketlist", style: GoogleFonts.anton(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          color: Color(0xFFFCC300),
                          size: 70,
                        ),
                      ),
                      const Text("ADD PHOTO",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
            textField("21/12/2024", Icons.calendar_month_rounded),
            const Gap(10),
            textField("Paris or France", Icons.location_on_outlined),
            const Gap(10),
            dropdown(),
            const Gap(10),
            Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Description",
                  contentPadding: EdgeInsets.all(50),
                  hintStyle: TextStyle(fontSize: 12, color: Colors.black38),
                ),
              ),
            ),
            const Gap(10),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget textField(String hint, IconData? icon, {int? maxLines}) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          contentPadding: const EdgeInsets.all(10),
          hintStyle: const TextStyle(fontSize: 12, color: Colors.black38),
          suffixIcon: icon != null
              ? IconButton(onPressed: () {}, icon: Icon(icon))
              : null,
        ),
      ),
    );
  }

  Widget dropdown() {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: selectedOption,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        underline: const SizedBox(),
        isExpanded: true,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(option,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue;
          });
        },
      ),
    );
  }

  Widget submitButton() {
    return Container(
      height: 40,
      width: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFFCC300),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text("Post",
            style: GoogleFonts.anton(color: Colors.black, fontSize: 20)),
      ),
    );
  }
}
