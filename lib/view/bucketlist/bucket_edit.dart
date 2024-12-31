import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/model/bucket_model/bucket.dart';
import 'package:textcodetripland/view/constants/custom_back_arrow.dart';
import 'package:textcodetripland/view/constants/custom_container.dart';
import 'package:textcodetripland/view/constants/custom_textformfield.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';
import 'package:textcodetripland/view/constants/customsnackbar.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

// ignore: must_be_immutable
class BucketEdit extends StatefulWidget {
  String? location;
  String? description;
  String? selectedTripType;
  DateTime? date;
  Uint8List? imageFile;
  int index;
  String? budget;

  BucketEdit({
    super.key,
    required this.date,
    required this.budget,
    required this.description,
    required this.imageFile,
    required this.location,
    required this.index,
    required this.selectedTripType,
  });

  @override
  State<BucketEdit> createState() => _BucketEditState();
}

class _BucketEditState extends State<BucketEdit> {
  TextEditingController _locationController = TextEditingController();
  TextEditingController _budgetController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String? _selectedTripType;
  DateTime? _date;
  Uint8List? _imageBytes;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? selectDate = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(2100),
      initialDate: now,
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
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes; // Store image as Uint8List
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
    "Weekend Getaway",
  ];

  Future<void> _updateBucket() async {
    final location = _locationController.text;
    final date = _date;
    final budget = _budgetController.text;
    final description = _descriptionController.text;
    final imageFile = _imageBytes;
    final tripType = _selectedTripType;

    final update = Bucket(
      budget: budget,
      date: date,
      location: location,
      description: description,
      imageFile: imageFile, // Pass Uint8List
      selectedTripType: tripType,
    );

    CustomSnackBar.show(
      context: context,
      message: "Bucket list trip edited! Adventure awaits",
      textColor: Colors.green,
    );

    editBucket(widget.index, update);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotchBar()),
    );
  }

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: widget.location);
    _descriptionController = TextEditingController(text: widget.description);
    _budgetController = TextEditingController(text: widget.budget);

    _selectedTripType = widget.selectedTripType;
    _date = widget.date;
    _imageBytes = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Bucketlist", style: CustomTextStyle.headings),
        centerTitle: true,
        leading: CustomBackButton(ctx: context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: CustomContainer(
                  height: 250,
                  width: 300,
                  color: Colors.black87,
                  child: GestureDetector(
                    onTap:
                        _pickImage, // Allow image selection when tapping the container
                    child: _imageBytes == null
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
                            child: Image.memory(
                              // Display the selected image
                              _imageBytes!,
                              fit: BoxFit.cover,
                              height: 300,
                              width: 300,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () => _pickDate(context),
                child: CustomContainer(
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
                                style: CustomTextStyle.textstyle2),
                            const Icon(Icons.calendar_month_rounded)
                          ],
                        )))),
            const Gap(10),
            CustomContainer(
                child: CustomTextFormField(
                    controller: _locationController,
                    hintText: "Paris or France",
                    suffixIcon: const Icon(Icons.location_on_outlined))),
            const Gap(10),
            CustomContainer(
              child: CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: _budgetController,
                hintText: "₹19999",
                suffixIcon: const Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const Gap(10),
            CustomContainer(
              child: DropdownButton<String>(
                value:
                    _selectedTripType, // Use _selectedTripType instead of selectedOption
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
                      child: Text(option, style: CustomTextStyle.empty),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTripType = newValue; // Update the selected value
                  });
                },
              ),
            ),
            const Gap(10),
            CustomContainer(
              height: 100,
              child: CustomTextFormField(
                controller: _descriptionController,
                hintText: "Description",
                maxLines: null, // Allows the field to grow dynamically
              ),
            ),
            const Gap(10),
            Custombutton(text: "UPDATE BUCKET", onPressed: _updateBucket)
          ],
        ),
      ),
    );
  }
}
