import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/activities_controlers.dart';
import 'package:textcodetripland/model/activities_model/activities.dart';
import 'package:textcodetripland/view/constants/custom_back_arrow.dart';
import 'package:textcodetripland/view/constants/custom_textformfield.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';
import 'package:textcodetripland/view/dayplanner/day_planner.dart';

class PlanYourDayAdd extends StatefulWidget {
  const PlanYourDayAdd({
    super.key,
  });
  @override
  State<PlanYourDayAdd> createState() => _PlanYourDayAddState();
}

class _PlanYourDayAddState extends State<PlanYourDayAdd> {
  final TextEditingController _activitiesController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  String fromTime = "From Time";
  String toTime = "To Time";

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Plan Your Day", style: CustomTextStyle.headings),
        centerTitle: true,
        leading: CustomBackButton(ctx: context),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
                  Text("Enter Activity",
                      style: GoogleFonts.anton(color: Colors.white)),
                  Container(
                    height: 50,
                    width: 330,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomTextFormField(
                      controller: _activitiesController,
                      hintText: "Breakfast at hotel",
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => selectedTime("From Time"),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(fromTime,
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.textStyle6),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => selectedTime("To Time"),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(toTime,
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.textStyle6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Text("Locations",
                      style: GoogleFonts.anton(color: Colors.white)),
                  Container(
                    height: 50,
                    width: 330,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomTextFormField(
                      controller: _placeController,
                      hintText: "Delhi",
                    ),
                  ),
                  const Gap(5),
                  Text("Transportation",
                      style: GoogleFonts.anton(color: Colors.white)),
                  Container(
                    height: 50,
                    width: 330,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
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
      "Please enter the location": _placeController.text.isEmpty,
      "Please enter the transportation": _vehicleController.text.isEmpty,
      "Please select the from time": fromTime == "From Time",
      "Please select the to time": toTime == "To Time",
    };

    for (var msg in validations.entries) {
      if (msg.value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg.key),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 2),
        ));
        return;
      }
    }

    final activities = Activities(
      activity: _activitiesController.text,
      fromTime: fromTime,
      toTime: toTime,
      place: _placeController.text,
      vehicle: _vehicleController.text,
    );

    addActivities(activities);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DayPlanner()));
  }
}
