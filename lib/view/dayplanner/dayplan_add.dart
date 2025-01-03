import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/activities_controlers.dart';
import 'package:textcodetripland/model/activities_model/activities.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_textformfield.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/widgets/custombutton.dart';

class PlanYourDayAdd extends StatefulWidget {
  final Trip tripdata;
  final int indexofday;
  const PlanYourDayAdd(
      {super.key, required this.indexofday, required this.tripdata});
  @override
  State<PlanYourDayAdd> createState() => _PlanYourDayAddState();
}

class _PlanYourDayAddState extends State<PlanYourDayAdd> {
  final TextEditingController _activitiesController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  String fromTime = "From Time";
  String toTime = "To Time";
  @override
  void initState() {
    getAllActivities(widget.tripdata.id, widget.indexofday);
    super.initState();
  }

  Future<void> selectedTime(String label) async {
    TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null) {
      setState(() {
        if (label == "From Time") {
          fromTime = selectedTime.format(context);
        } else {
          toTime = selectedTime.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Plan Your Day",
        ctx: context,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 500,
            width: 360,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(40),
                  const Text(
                    "Enter Activity",
                    style: CustomTextStyle.textStyle7,
                  ),
                  CustomContainer(
                    color: Colors.white,
                    child: CustomTextFormField(
                      controller: _activitiesController,
                      hintText: "Breakfast at hotel",
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("From Time",
                            style: GoogleFonts.roboto(color: Colors.white)),
                        Text("To Time",
                            style: GoogleFonts.roboto(color: Colors.white)),
                      ],
                    ),
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => selectedTime("From Time"),
                        child: CustomContainer(
                          width: 150,
                          color: Colors.white,
                          child: Center(
                            child: Text(fromTime,
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.textStyle6),
                          ),
                        ),
                      ),
                      const Gap(20),
                      GestureDetector(
                          onTap: () => selectedTime("To Time"),
                          child: CustomContainer(
                            width: 150,
                            color: Colors.white,
                            child: Center(
                              child: Text(toTime,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyle.textStyle6),
                            ),
                          )),
                    ],
                  ),
                  const Gap(10),
                  const Text(
                    "Locations",
                    style: CustomTextStyle.textStyle7,
                  ),
                  CustomContainer(
                    color: Colors.white,
                    child: CustomTextFormField(
                      controller: _placeController,
                      hintText: "Delhi",
                    ),
                  ),
                  const Gap(5),
                  const Text(
                    "Transportation",
                    style: CustomTextStyle.textStyle7,
                  ),
                  CustomContainer(
                    color: Colors.white,
                    child: CustomTextFormField(
                      controller: _vehicleController,
                      hintText: "Car or Flight",
                    ),
                  ),
                  const Gap(20),
                  Center(
                    child: Custombutton(
                      text: "ADD ACTIVITIES",
                      onPressed: onAddActivities,
                      horizontalPadding: 10, // Custom horizontal padding
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddActivities() async {
    final validations = {
      "Please enter the activities": _activitiesController.text.isEmpty,
      'Activites must not contain numbers or emojis':
          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(_activitiesController.text),
      "Please enter the location": _placeController.text.isEmpty,
      'Place must not contain numbers or emojis':
          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(_placeController.text),
      "Please enter the transportation": _vehicleController.text.isEmpty,
      'Vehicle must not contain numbers or emojis':
          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(_vehicleController.text),
      "Please select the from time": fromTime == "From Time",
      "Please select the to time": toTime == "To Time",
    };
    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg.key),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 3),
        ));
        return;
      }
    }

    final activities = Activities(
      tripid: widget.tripdata.id,
      indexofday: widget.indexofday,
      activity: _activitiesController.text,
      fromTime: fromTime,
      toTime: toTime,
      place: _placeController.text,
      vehicle: _vehicleController.text,
    );

    addActivities(activities);
    Navigator.of(context).pop();
  }
}
