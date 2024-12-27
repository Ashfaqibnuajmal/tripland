import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/model/bucket_model/bucket.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';
import 'package:textcodetripland/view/constants/custom_textformfield.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';
import 'package:textcodetripland/view/constants/customsnackbar.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

class BucketlistAdd extends StatefulWidget {
  const BucketlistAdd({super.key});

  @override
  State<BucketlistAdd> createState() => _BucketlistAddState();
}

class _BucketlistAddState extends State<BucketlistAdd> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _date;
  String? _selectedTripType;
  File? _selectedImage;
  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
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

  Future<void> onAddBucket() async {
    final validations = {
      "Please add a photo": _selectedImage == null,
      "Please enter a date": _date == null,
      "Please enter a location": _locationController.text.isEmpty,
      "Please enter a budget": _budgetController.text.isEmpty,
      "Please enter a trip type": _selectedTripType == null,
      "Please enter description": _descriptionController.text.isEmpty
    };
    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text(msg.key),
          duration: const Duration(seconds: 2),
        ));
        return;
      }
    }
    final bucket = Bucket(
        date: _date,
        location: _locationController.text,
        budget: _budgetController.text,
        description: _descriptionController.text,
        imageFile: _selectedImage?.path,
        selectedTripType: _selectedTripType);
    addBucket(bucket);
    CustomSnackBar.show(
        context: context,
        message: "Bucket list trip added! Adventure awaits!",
        textColor: Colors.green);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotchBar()),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Add Bucketlist",
        ctx: context,
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
                    child: _selectedImage == null
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
                              _selectedImage!,
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
                              style: CustomTextStyle.textstyle2),
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
                child: CustomTextFormField(
                    controller: _locationController,
                    hintText: "Paris or France",
                    suffixIcon: const Icon(Icons.location_on_outlined))),
            const Gap(10),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomTextFormField(
                controller: _budgetController,
                hintText: "₹19999",
                suffixIcon: const Icon(Icons.currency_rupee_rounded),
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
                      child: Text(option, style: CustomTextStyle.textstyle2),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTripType = newValue; // Update _selectedTripType
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
                controller: _descriptionController,
                hintText: "Description",
                maxLines: null, // Allows the field to grow dynamically
              ),
            ),
            const Gap(10),
            Custombutton(text: "ADD BUCKET", onPressed: onAddBucket)
          ],
        ),
      ),
    );
  }
}
