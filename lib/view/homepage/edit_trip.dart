import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_textformfield.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/widgets/custombutton.dart';
import 'package:textcodetripland/view/widgets/customsnackbar.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

// ignore: must_be_immutable
class TripEdit extends StatefulWidget {
  String? location;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedNumberOfPeople;
  String? selectedTripType;
  String? expance;
  Uint8List? imageFile;
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
  Uint8List? _selectedImage;

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
      _selectedImage = widget.imageFile;
    }
  }

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
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null; // Reset end date if it's invalid
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
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = bytes; // Store image as Uint8List
      });
    }
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
      imageFile: imageFile,
    );

    CustomSnackBar.show(
        context: context,
        message: "Trip updated successfully. You're good to go!",
        textColor: Colors.green);
    editTrip(widget.index, update);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotchBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Let me edit my trip", style: CustomTextStyle.headings),
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
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomContainer(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomContainer(
                    child: CustomTextFormField(
                      controller: _expanceController,
                      keyboardType: TextInputType.number,
                      hintText: "₹ 29999",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text("Trip Image", style: CustomTextStyle.textStyle5),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                        height: 200,
                        width: 330,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _selectedImage == null
                            ? const Icon(Icons.camera_alt_outlined)
                            : Image.memory(_selectedImage!)),
                  ),
                ),
              ],
            ),
            const Gap(20),

            Custombutton(text: 'UPDATE ITINERARY', onPressed: _updateItinerary)
          ],
        ),
      ),
    );
  }
}
