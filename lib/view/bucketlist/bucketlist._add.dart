import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/model/bucket_model/bucket.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';
import 'package:textcodetripland/view/constants/custom_container.dart';
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
  Uint8List? _selectedImage;

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

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

  Future<void> onAddBucket() async {
    final validations = {
      "Please add a photo": _selectedImage == null,
      "Please enter a date": _date == null,
      "Please enter a location": _locationController.text.isEmpty,
      'Location must not contain numbers or emojis':
          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(_locationController.text),
      "Please enter a budget": _budgetController.text.isEmpty,
      "Please enter a trip type": _selectedTripType == null,
      "Please enter description": _descriptionController.text.isEmpty,
      'Description must be contain atleast 10 characters.':
          _descriptionController.text.length < 10
    };
    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text(msg.key),
          duration: const Duration(seconds: 3),
        ));
        return;
      }
    }
    final bucket = Bucket(
        date: _date,
        location: _locationController.text,
        budget: _budgetController.text,
        description: _descriptionController.text,
        imageFile: _selectedImage, // Passing the image file as Uint8List
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
      setState(() async {
        _selectedImage =
            await pickedFile.readAsBytes(); // Store image as Uint8List
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
                  child: CustomContainer(
                      height: 250,
                      width: 300,
                      color: Colors.black87,
                      child: _selectedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed:
                                      _pickImage, // Pick image when tapped
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
                                // Display the selected image using memory
                                _selectedImage!,
                                fit: BoxFit.cover,
                                height: 300,
                                width: 300,
                              ),
                            ))),
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
                value: _selectedTripType,
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
                    _selectedTripType = newValue;
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
            Custombutton(text: "ADD BUCKET", onPressed: onAddBucket)
          ],
        ),
      ),
    );
  }
}
