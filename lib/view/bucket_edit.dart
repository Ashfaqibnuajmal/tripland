import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/model/bucket.dart';

// ignore: must_be_immutable
class BucketEdit extends StatefulWidget {
  String? location;
  String? description;
  String? tripType;
  DateTime? date;
  String? imageFile;
  int index;
  BucketEdit(
      {super.key,
      this.date,
      this.description,
      this.imageFile,
      this.location,
      required this.index,
      this.tripType});

  @override
  State<BucketEdit> createState() => _BucketEditState();
}

class _BucketEditState extends State<BucketEdit> {
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _tripType;
  DateTime? _date;
  File? _imageFile;

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
        _imageFile = File(pickedFile.path); // Store the image file
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
  Future<void> _updateBucket() async {
    final location = _locationController.text;
    final date = _date;
    final description = _descriptionController.text;
    final imageFile = _imageFile;
    final tripType = _tripType;
    final update = Bucket(
        date: date,
        location: location,
        description: description,
        imageFile: imageFile?.path,
        selectedTripType: tripType);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.airplane_ticket_rounded,
              color: Colors.green,
            ),
            Text(
              "Update complete! Your trip is ready to go.",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
    editBucket(widget.index, update);
  }

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: widget.location);
    _descriptionController = TextEditingController(text: widget.description);
    _tripType = widget.tripType!;
    _date = widget.date;
    if (widget.imageFile != null) {
      _imageFile = File(widget.imageFile!);
    }
  }

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
                    child: _imageFile == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: _pickImage, // Pick image when tapped
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color(0xFFFCC300),
                                  size: 70,
                                ),
                              ),
                              const Text("ADD PHOTO",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              // Display the selected image
                              _imageFile!,
                              fit: BoxFit.cover,
                              height: 300,
                              width: 300,
                            ),
                          )),
              ),
            ),
            GestureDetector(
              onTap: () => _pickDate(context),
              child: Container(
                  height: 50,
                  width: 300,
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
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Paris or France",
                  contentPadding: const EdgeInsets.all(10),
                  hintStyle:
                      const TextStyle(fontSize: 12, color: Colors.black38),
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
                value:
                    _tripType, // Use _selectedTripType instead of selectedOption
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
                  setState(() {});
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
                controller: _descriptionController,
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
            GestureDetector(
              onTap: _updateBucket,
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCC300),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text("Post",
                      style:
                          GoogleFonts.anton(color: Colors.black, fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
