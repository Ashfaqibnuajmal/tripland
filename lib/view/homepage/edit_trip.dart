import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';
import 'package:textcodetripland/view/constants/customsnackbar.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

// ignore: must_be_immutable
class TripEdit extends StatefulWidget {
  String? location;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedNumberOfPeople;
  String? selectedTripType;
  String? expance;
  String? imageFile;
  int index;

  TripEdit({
    super.key,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.selectedNumberOfPeople,
    required this.selectedTripType,
    required this.expance,
    required this.imageFile,
    required this.index,
  });

  @override
  State<TripEdit> createState() => _TripEditState();
}

class _TripEditState extends State<TripEdit> {
  TextEditingController _locationController = TextEditingController();
  TextEditingController _selectedNumberOfPeople = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedTripType;
  TextEditingController _expanceController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: widget.location);
    _expanceController = TextEditingController(text: widget.expance);
    _selectedNumberOfPeople =
        TextEditingController(text: widget.selectedNumberOfPeople);
    _startDate = widget.startDate;
    _endDate = widget.endDate;
    _selectedTripType = widget.selectedTripType!;
    if (widget.imageFile != null) {
      _selectedImage = File(widget.imageFile!);
    }
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime? selectedDate = await showDatePicker(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            Text("Let me edi my trip", style: GoogleFonts.anton(fontSize: 20)),
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
            Custombutton(text: "UPDATE ITITNERARY", onPressed: _updateItinerary)
          ],
        ),
      ),
    );
  }

  Future<void> _updateItinerary() async {
    final location = _locationController.text;
    final startDate = _startDate;
    final endDate = _endDate;
    final selectedNumberOfPeople = _selectedNumberOfPeople.text;
    final selectedTripType = _selectedTripType;
    final expance = _expanceController.text;
    final imageFile = _selectedImage;

    final update = Trip(
      location: location,
      startDate: startDate,
      endDate: endDate,
      selectedNumberOfPeople: selectedNumberOfPeople,
      selectedTripType: selectedTripType,
      expance: expance,
      imageFile: imageFile?.path,
    );

    CustomSnackBar.show(
        context: context,
        message: "Trip updated successfully. You're good to go!",
        textColor: Colors.green);
    editTrip(widget.index, update);
    Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => NotchBar()));
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("Let me plan my trip", style: CustomTextStyle.headings),
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
              Text("Itinerary Location", style: CustomTextStyle.textStyle5),
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
                  hintStyle: CustomTextStyle.hintText),
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
          child: Text(label, style: CustomTextStyle.textStyle5)),
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
              Text("Number of People", style: CustomTextStyle.textStyle5),
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
                hintStyle: CustomTextStyle.hintText,
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
              Text(label, style: CustomTextStyle.textStyle5),
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
              hint: Text(hint, style: CustomTextStyle.hintText),
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
              Text("Budget", style: CustomTextStyle.textStyle5),
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
                hintStyle: CustomTextStyle.hintText,
              ),
            ),
          ),
        ),
      ],
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
