import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/model/bucket_model/bucket.dart';
import 'package:textcodetripland/view/widgets/custom_back_arrow.dart';
import 'package:textcodetripland/view/widgets/custom_bucket_add.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/widgets/custombutton.dart';
import 'package:textcodetripland/view/widgets/customsnackbar.dart';
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
      MaterialPageRoute(builder: (context) => const NotchBar()),
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
            BucketEditForm(
              locationController: _locationController,
              budgetController: _budgetController,
              descriptionController: _descriptionController,
              selectedTripType: _selectedTripType,
              date: _date,
              imageFile: _imageBytes,
              options: options,
              updateBucket: _updateBucket,
              pickDate: _pickDate,
              pickImage: _pickImage,
            ),
            const Gap(10),
            Custombutton(text: "UPDATE BUCKET", onPressed: _updateBucket)
          ],
        ),
      ),
    );
  }
}
