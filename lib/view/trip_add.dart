import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/trip.dart';
import 'package:textcodetripland/view/bottom_navigation.dart';

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
  // String? _selectedNumberOfPeople;
  String? _selectedTripType;
  File? _selectedImage;

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> onAddTrip() async {
    final validations = {
      'Please enter a location': _locationController.text.isEmpty,
      'Please select a start date': _startDate == null,
      'Please select an end date': _endDate == null,
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
              duration: const Duration(seconds: 2)),
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
      imageFile: _selectedImage?.path,
    );

    addTrip(trip);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.airplane_ticket_rounded,
            color: Colors.green,
          ),
          Text(
            "Trip created! Start planning your journey.",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    ));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NotchBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              locationField(),
              const SizedBox(height: 20),
              datePickers(),
              const SizedBox(height: 20),
              nummberOfPeopleField(),
              const SizedBox(height: 20),
              tripTypeDropdown(),
              const Gap(20),
              budgetField(),
              const SizedBox(height: 20),
              imagePickerButton(),
              const SizedBox(height: 20),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Widgets
  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "Let me plan my trip",
        style: GoogleFonts.anton(fontSize: 20),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_rounded, size: 25),
      ),
    );
  }

  Widget locationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Icon(Icons.location_pin),
              Text(
                "Itinerary Location",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            height: 60,
            width: 330,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: _locationController,
              textAlign: TextAlign.center,
              validator: (value) =>
                  value?.isEmpty ?? true ? "Please enter the location" : null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Paris or France",
                contentPadding: EdgeInsets.all(15),
                hintStyle: TextStyle(fontSize: 12, color: Colors.black38),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget datePickers() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(Icons.date_range_rounded),
                Text(
                  "Start date",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.date_range_rounded),
                Text(
                  "End date",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            dateContainer(
              label: _startDate != null
                  ? DateFormat('dd/MM/yyyy').format(_startDate!)
                  : "Select Date",
              onTap: () => _pickDate(context, true),
            ),
            dateContainer(
              label: _endDate != null
                  ? DateFormat('dd/MM/yyyy').format(_endDate!)
                  : "Select Date",
              onTap: () => _pickDate(context, false),
            ),
          ],
        ),
      ],
    );
  }

  Widget dateContainer({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget nummberOfPeopleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Icon(Icons.people_outline_sharp),
              Text(
                "Number of People",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            height: 60,
            width: 330,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: _selectedNumberOfPeople,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              validator: (value) => value?.isEmpty ?? true
                  ? "Please enter the number of people"
                  : null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "7 Persons",
                contentPadding: EdgeInsets.all(15),
                hintStyle: TextStyle(fontSize: 12, color: Colors.black38),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tripTypeDropdown() {
    return dropdown(
      icon: Icons.transfer_within_a_station_sharp,
      label: "Trip Guides",
      hint: "Select trip type",
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
      ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (value) {
        setState(() {
          _selectedTripType = value;
        });
      },
    );
  }

  Widget dropdown({
    required IconData icon,
    required String label,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Icon(icon),
              Text(
                label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            height: 60,
            width: 330,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
              hint: Text(
                hint,
                style: const TextStyle(fontSize: 12, color: Colors.black38),
              ),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget budgetField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Icon(Icons.attach_money_rounded),
              Text(
                "Budget",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            height: 60,
            width: 330,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: _expanceController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              validator: (value) =>
                  value?.isEmpty ?? true ? "Please enter the expense" : null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "₹ 29999",
                contentPadding: EdgeInsets.all(15),
                hintStyle: TextStyle(fontSize: 12, color: Colors.black38),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: onAddTrip,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFCC300),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'SAVE ITINERARY',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: -1,
        ),
      ),
    );
  }

  Widget imagePickerButton() {
    return GestureDetector(
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
                child: Image.file(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
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
    );
  }
}
