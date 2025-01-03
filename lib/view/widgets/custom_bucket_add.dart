import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_textformfield.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class BucketEditForm extends StatefulWidget {
  final TextEditingController locationController;
  final TextEditingController budgetController;
  final TextEditingController descriptionController;
  final String? selectedTripType;
  final DateTime? date;
  final Uint8List? imageFile;
  final List<String> options;
  final Function updateBucket;
  final Function pickDate;
  final VoidCallback pickImage; // Make sure it's of type VoidCallback

  const BucketEditForm({
    super.key,
    required this.locationController,
    required this.budgetController,
    required this.descriptionController,
    required this.selectedTripType,
    required this.date,
    required this.imageFile,
    required this.options,
    required this.updateBucket,
    required this.pickDate,
    required this.pickImage, // Ensure pickImage is passed as VoidCallback
  });

  @override
  // ignore: library_private_types_in_public_api
  _BucketEditFormState createState() => _BucketEditFormState();
}

class _BucketEditFormState extends State<BucketEditForm> {
  String? _selectedTripType;
  DateTime? _date;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _selectedTripType = widget.selectedTripType;
    _date = widget.date;
    _imageBytes = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: CustomContainer(
              height: 250,
              width: 300,
              color: Colors.black87,
              child: GestureDetector(
                onTap: widget.pickImage, // Now correctly using VoidCallback
                child: _imageBytes == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed:
                                widget.pickImage, // Correct function call
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
          onTap: () => widget.pickDate(context),
          child: CustomContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _date == null
                        ? "Select a date"
                        : DateFormat('dd/MM/yyyy').format(_date!),
                    style: CustomTextStyle.textstyle2,
                  ),
                  const Icon(Icons.calendar_month_rounded),
                ],
              ),
            ),
          ),
        ),
        const Gap(10),
        CustomContainer(
          child: CustomTextFormField(
            controller: widget.locationController,
            hintText: "Paris or France",
            suffixIcon: const Icon(Icons.location_on_outlined),
          ),
        ),
        const Gap(10),
        CustomContainer(
          child: CustomTextFormField(
            keyboardType: TextInputType.number,
            controller: widget.budgetController,
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
            items: widget.options.map((String option) {
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
            controller: widget.descriptionController,
            hintText: "Description",
            maxLines: null,
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
