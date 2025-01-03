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

class JournalAdd extends StatefulWidget {
  const JournalAdd({super.key});

  @override
  State<JournalAdd> createState() => _JournalAddState();
}

class _JournalAddState extends State<JournalAdd> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _journalController = TextEditingController();
  DateTime? _date;
  final List<File> _selectedImages = []; // List to store selected images
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

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles =
        await picker.pickMultiImage(); // Pick multiple images

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
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
      "Please give the Image": _selectedImages.isEmpty, // Check for no images
      "Please enter the date ": _date == null,
      "Please enter the time": time == "Select Time",
      "Please enter the location": _locationController.text.isEmpty,
      'Location must not contain numbers or emojis':
          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(_locationController.text),
      "Please enter the tripType": _selectedTripType == null,
      "Please enter the journal": _journalController.text.isEmpty,
      'Journal must be contanis atleast 10  characters.':
          _journalController.text.length < 10,
    };
    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.black,
              content: Text(msg.key),
              duration: const Duration(seconds: 3)),
        );
        return;
      }
    }

    final journal = Journal(
        date: _date!,
        imageFiles: _selectedImages
            .map((e) => e.path)
            .toList(), // Store paths of multiple images
        journal: _journalController.text,
        location: _locationController.text,
        selectedTripType: _selectedTripType,
        time: time);

    addJournal(journal); // Add the journal to the list
    CustomSnackBar.show(
      context: context,
      message: "Journal added! Ready to go.",
      textColor: Colors.green,
    );

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NotchBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Journal Add",
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
                          const Text("ADD PHOTOS",
                              style: TextStyle(color: Colors.white)),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GridView.builder(
                          itemCount: _selectedImages.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Image.file(
                              _selectedImages[index],
                              fit: BoxFit.cover,
                            );
                          },
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
                                      : DateFormat('dd/MM/yyyy')
                                          .format(_date!), // Format the date
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(Icons.calendar_month_rounded)
                              ],
                            )))),
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
                            const Icon(Icons.timelapse_rounded)
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          const Gap(10),
          CustomContainer(
              child: CustomTextFormField(
            controller: _locationController,
            hintText: "Paris or France",
            suffixIcon: const Icon(Icons.location_on_outlined),
          )),
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
          CustomContainer(
              height: 100,
              child: CustomTextFormField(
                controller: _journalController,
                hintText: "Journal text",
                maxLines: null,
              )),
          const Gap(10),
          Custombutton(text: "ADD JOURNAL", onPressed: onAddJournal)
        ]),
      ),
    );
  }
}
