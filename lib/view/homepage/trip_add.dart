import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/widgets/custom_back_arrow.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_textformfield.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/widgets/custombutton.dart';
import 'package:textcodetripland/view/widgets/customsnackbar.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

class TripAdd extends StatefulWidget {
  const TripAdd({super.key});

  @override
  State<TripAdd> createState() => _TripAddState();
}

class _TripAddState extends State<TripAdd> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _expanceController = TextEditingController();
  final TextEditingController _selectedNumberOfPeople = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedTripType;
  Uint8List? _selectedImage;

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime now = DateTime.now(); // Get today's date
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now, // Start with today's date
      firstDate: now, // Restrict past dates
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
          // If end date is before the start date, reset it
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          if (_startDate != null && selectedDate.isBefore(_startDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("End date must be after the start date"),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            _endDate = selectedDate;
          }
        }
      });
    }
  }

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

  Future<void> onAddTrip() async {
    final validations = {
      'Please enter a location': _locationController.text.isEmpty,
      'Location must not contain numbers or emojis':
          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(_locationController.text),
      'Please select a start date': _startDate == null,
      'Please select an end date': _endDate == null,
      'End date must be after the start date': _startDate != null &&
          _endDate != null &&
          _endDate!.isBefore(_startDate!),
      'Please select the number of people':
          _selectedNumberOfPeople.text.isEmpty,
      'Please select a trip type':
          _selectedTripType == null || _selectedTripType!.isEmpty,
      'Please enter the trip expense': _expanceController.text.isEmpty,
      'Please select an image': _selectedImage == null,
    };

    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(msg.key),
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }
    }

    final trip = Trip(
      location: _locationController.text,
      startDate: _startDate!,
      endDate: _endDate!,
      selectedNumberOfPeople: _selectedNumberOfPeople.text,
      selectedTripType: _selectedTripType,
      expance: _expanceController.text,
      imageFile: _selectedImage,
    );

    addTrip(trip);
    CustomSnackBar.show(
        context: context,
        message: "Trip added! Ready for adventure.",
        textColor: Colors.green);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NotchBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Let me plan my trip", style: CustomTextStyle.headings),
        centerTitle: true,
        leading: CustomBackButton(ctx: context),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Location Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(40),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      children: [
                        Icon(Icons.location_pin),
                        Text("Itinerary Location",
                            style: CustomTextStyle.textStyle5),
                      ],
                    ),
                  ),
                  CustomContainer(
                    child: CustomTextFormField(
                      controller: _locationController,
                      hintText: "Paris or France",
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Date Pickers
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range_rounded),
                          Text("Start date", style: CustomTextStyle.textStyle6)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.date_range_rounded),
                          Text("End date", style: CustomTextStyle.textStyle6)
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => _pickDate(context, true),
                        child: CustomContainer(
                            width: 130,
                            child: Center(
                                child: Text(
                                    _startDate != null
                                        ? DateFormat('dd/MM/yyyy')
                                            .format(_startDate!)
                                        : "Select Date",
                                    style: CustomTextStyle.textStyle5))),
                      ),
                      GestureDetector(
                        onTap: () => _pickDate(context, false),
                        child: CustomContainer(
                            width: 130,
                            child: Center(
                                child: Text(
                                    _endDate != null
                                        ? DateFormat('dd/MM/yyyy')
                                            .format(_endDate!)
                                        : "Select Date",
                                    style: CustomTextStyle.textStyle5))),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Number of People Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      children: [
                        Icon(Icons.people_outline_sharp),
                        Text("Number of People",
                            style: CustomTextStyle.textStyle5),
                      ],
                    ),
                  ),
                  CustomContainer(
                    child: CustomTextFormField(
                      controller: _selectedNumberOfPeople,
                      keyboardType: TextInputType.number,
                      hintText: "7 Persons",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Trip Type Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      children: [
                        Icon(Icons.transfer_within_a_station_sharp),
                        Text("Trip Guides", style: CustomTextStyle.textStyle5),
                      ],
                    ),
                  ),
                  CustomContainer(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      hint: const Text("Select trip type",
                          style: CustomTextStyle.hintText),
                      items: [
                        "Solo",
                        "Adventure",
                        "Family",
                        "Romantic",
                        "Honeymoon",
                        "Cultural",
                        "Road Trip",
                        "Luxury",
                        "Backpacking",
                        "Nature Exploration",
                      ]
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTripType = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Gap(20),

              // Budget Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      children: [
                        Icon(Icons.attach_money_rounded),
                        Text("Budget", style: CustomTextStyle.textStyle5),
                      ],
                    ),
                  ),
                  CustomContainer(
                    child: CustomTextFormField(
                      controller: _expanceController,
                      keyboardType: TextInputType.number,
                      hintText: "₹ 29999",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: _selectedImage != null
                    ? Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white38,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
              ),
              const Gap(20),
              Custombutton(text: 'SAVE ITINERARY', onPressed: onAddTrip)
            ],
          ),
        ),
      ),
    );
  }
}
