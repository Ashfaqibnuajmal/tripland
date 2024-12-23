import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/journal_controllers.dart';
import 'package:textcodetripland/model/journal_model/journal.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';
import 'package:textcodetripland/view/constants/customsnackbar.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

class JournalAdd extends StatefulWidget {
  const JournalAdd({super.key});

  @override
  State<JournalAdd> createState() => _JournalAddState();
}

class _JournalAddState extends State<JournalAdd> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _journalController = TextEditingController();
  DateTime? _date;
  File? _selectedImage;
  String time = "Select Time";
  String? _selectedTripType;
  Future<void> selectedTime() async {
    TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null) {
      setState(() {
        time = selectedTime.format(context);
      });
    }
  }

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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Store the image file
      });
    }
  }

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
  Future<void> onAddJournal() async {
    final validations = {
      "Please give the Image": _selectedImage == null,
      "Please enter the date ": _date == null,
      "Please enter the time": time == "Select Time",
      "Please enter the location": _locationController.text.isEmpty,
      "Please enter the tripType": _selectedTripType == null,
      "Please enter the journal": _journalController.text.isEmpty
    };
    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.black,
              content: Text(msg.key),
              duration: const Duration(seconds: 2)),
        );
        return;
      }
    }
    final journal = Journal(
        date: _date!,
        imageFile: _selectedImage?.path,
        journal: _journalController.text,
        location: _locationController.text,
        selectedTripType: _selectedTripType,
        time: time);
    addJournal(journal);
    CustomSnackBar.show(
      context: context,
      message: "Journal added! Ready to go.",
      textColor: Colors.green,
    );

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotchBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Add Journal", style: GoogleFonts.anton(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
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
                child: _selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.camera_alt_rounded,
                                color: Color(0xFFFCC300), size: 70),
                          ),
                          const Text("ADD PHOTO",
                              style: TextStyle(color: Colors.white)),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          height: 300,
                          width: 300,
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _pickDate(context),
                  child: Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _date == null
                                    ? "Select a date"
                                    : DateFormat('dd/MM/yyyy')
                                        .format(_date!), // Format the date
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(Icons.calendar_month_rounded)
                            ],
                          ))),
                ),
                GestureDetector(
                  onTap: selectedTime,
                  child: Container(
                    height: 50,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            time,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          const Icon(Icons.timelapse_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: _locationController,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Paris or France",
                contentPadding: const EdgeInsets.all(10),
                hintStyle: const TextStyle(fontSize: 12, color: Colors.black38),
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on_outlined)),
              ),
            ),
          ),
          const Gap(10),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: _selectedTripType,
              hint: const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Center(
                  child: Text(
                    "Select a trip type",
                    style: TextStyle(color: Colors.black38, fontSize: 15),
                  ),
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              underline: const SizedBox(),
              isExpanded: true,
              style: const TextStyle(color: Colors.black, fontSize: 10),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(option, style: const TextStyle(fontSize: 15)),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTripType = newValue; // Update the state
                });
              },
            ),
          ),
          const Gap(10),
          Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: _journalController,
              textAlign: TextAlign.center,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Journal text",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                hintStyle: TextStyle(fontSize: 12, color: Colors.black38),
              ),
            ),
          ),
          const Gap(10),
          Custombutton(text: "ADD JOURNAL", onPressed: onAddJournal)
        ]),
      ),
    );
  }
}
