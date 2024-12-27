import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/journal_controllers.dart';
import 'package:textcodetripland/model/journal_model/journal.dart';
import 'package:textcodetripland/view/constants/custom_textformfield.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';
import 'package:textcodetripland/view/constants/customsnackbar.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

// ignore: must_be_immutable
class JournalEdit extends StatefulWidget {
  String? location;
  String? journal;
  String? selectedTripType;
  DateTime? date;
  int index;
  String? imageFile;
  String? time;
  JournalEdit({
    super.key,
    required this.date,
    required this.imageFile,
    required this.index,
    required this.journal,
    required this.location,
    required this.time,
    required this.selectedTripType,
  });

  @override
  State<JournalEdit> createState() => _JournalEditState();
}

class _JournalEditState extends State<JournalEdit> {
  TextEditingController _locationController = TextEditingController();
  TextEditingController _journalController = TextEditingController();
  String? _selectedTripType;
  DateTime? _date;
  File? _selectedImage;
  String time = "Select Time";
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
  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: widget.location);
    _journalController = TextEditingController(text: widget.journal);
    _selectedTripType = widget.selectedTripType;
    _date = widget.date;
    time = widget.time ?? "Select Time";
    if (widget.imageFile != null) {
      _selectedImage = File(widget.imageFile!);
    }
  }

  Future<void> _updateJournal() async {
    final location = _locationController.text;
    final date = _date;
    final journal = _journalController.text; // Use the correct controller
    final imageFile =
        _selectedImage; // Assuming _selectedImage holds the image file
    final tripType = _selectedTripType;
    final selectedTime = time; // Add the time here

    final updatedJournal = Journal(
      date: date,
      location: location,
      journal: journal,
      imageFile: imageFile?.path, // Convert image file to path if necessary
      selectedTripType: tripType,
      time: selectedTime, // Include the time in the updated journal
    );

    CustomSnackBar.show(
        context: context,
        message: "Journal updated! Your changes are saved.",
        textColor: Colors.green);
    editJournal(widget.index, updatedJournal);

    // Navigate to NotchBar screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotchBar()),
    );
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
              child: CustomTextFormField(
                controller: _locationController,
                hintText: "Paris or France",
                suffixIcon: const Icon(Icons.location_on_outlined),
              )),
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
              child: CustomTextFormField(
                controller: _journalController,
                hintText: "Journal text",
                maxLines: null,
              )),
          const Gap(10),
          Custombutton(text: "UPDATE JOURNAL", onPressed: _updateJournal)
        ]),
      ),
    );
  }
}
