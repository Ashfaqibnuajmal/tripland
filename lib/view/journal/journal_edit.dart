import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/journal_controllers.dart';
import 'package:textcodetripland/model/journal_model/journal.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_textformfield.dart';
import 'package:textcodetripland/view/widgets/custombutton.dart';
import 'package:textcodetripland/view/widgets/customsnackbar.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

// ignore: must_be_immutable
class JournalEdit extends StatefulWidget {
  String? location;
  String? journal;
  String? selectedTripType;
  DateTime? date;
  int index;
  List<String> imageFile;
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
  late TextEditingController _locationController;
  late TextEditingController _journalController;
  String? _selectedTripType;
  DateTime? _date;
  List<File> _selectedImages = [];
  String time = "Select Time";

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: widget.location);
    _journalController = TextEditingController(text: widget.journal);
    _selectedTripType = widget.selectedTripType;
    _date = widget.date;
    time = widget.time ?? "Select Time";

    if (widget.imageFile.isNotEmpty) {
      _selectedImages =
          widget.imageFile.map((path) => File(path)).toList(); // Load images
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

  Future<void> selectedTime() async {
    TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null) {
      setState(() {
        time = selectedTime.format(context);
      });
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.clear(); // Clear current images for editing
        _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  Future<void> _updateJournal() async {
    final location = _locationController.text;
    final date = _date;
    final journal = _journalController.text;
    final imageFile = _selectedImages;
    final tripType = _selectedTripType;
    final selectedTime = time;

    final updatedJournal = Journal(
      date: date,
      location: location,
      journal: journal,
      imageFiles: imageFile.map((file) => file.path).toList(),
      selectedTripType: tripType,
      time: selectedTime,
    );

    CustomSnackBar.show(
        context: context,
        message: "Journal updated! Your changes are saved.",
        textColor: Colors.green);
    editJournal(widget.index, updatedJournal);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NotchBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Edit Journal",
        ctx: context,
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
                child: _selectedImages.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _pickImages,
                            icon: const Icon(Icons.camera_alt_rounded,
                                color: Color(0xFFFCC300), size: 70),
                          ),
                          const Text("ADD PHOTO",
                              style: TextStyle(color: Colors.white)),
                        ],
                      )
                    : GestureDetector(
                        onTap: _pickImages,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _selectedImages[0],
                            fit: BoxFit.cover,
                            height: 300,
                            width: 300,
                          ),
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
                  child: CustomContainer(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _date == null
                                ? "Select a date"
                                : DateFormat('dd/MM/yyyy').format(_date!),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.calendar_month_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: selectedTime,
                  child: CustomContainer(
                    width: 150,
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
                          const Icon(Icons.timelapse_rounded),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Gap(10),
          CustomContainer(
            child: CustomTextFormField(
              controller: _locationController,
              hintText: "Location (e.g., Paris or France)",
              suffixIcon: const Icon(Icons.location_on_outlined),
            ),
          ),
          const Gap(10),
          CustomContainer(
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
              isExpanded: true,
              items: [
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
              ].map((String option) {
                return DropdownMenuItem(
                  value: option,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(option, style: const TextStyle(fontSize: 15)),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTripType = newValue;
                });
              },
            ),
          ),
          const Gap(10),
          CustomContainer(
            height: 100,
            child: CustomTextFormField(
              controller: _journalController,
              hintText: "Journal text",
              maxLines: null,
            ),
          ),
          const Gap(10),
          Custombutton(text: "UPDATE JOURNAL", onPressed: _updateJournal),
        ]),
      ),
    );
  }
}
