import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/activities_controlers.dart';
import 'package:textcodetripland/model/activities.dart';
import 'package:textcodetripland/view/day_planner.dart';

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
        title: Text("Plan Your Day", style: GoogleFonts.anton(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 25),
        ),
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
                    child: TextFormField(
                      controller: _activitiesController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Breakfast at hotel",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintStyle:
                            TextStyle(fontSize: 12, color: Colors.black38),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("From Time",
                            style: GoogleFonts.anton(color: Colors.white)),
                        Text("To Time",
                            style: GoogleFonts.anton(color: Colors.white)),
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
                            child: Text(
                              fromTime,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black),
                            ),
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
                            child: Text(
                              toTime,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black),
                            ),
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
                    child: TextFormField(
                      controller: _placeController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Delhi",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintStyle:
                            TextStyle(fontSize: 12, color: Colors.black38),
                      ),
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
                    child: TextFormField(
                      controller: _vehicleController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Car or Flight",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintStyle:
                            TextStyle(fontSize: 12, color: Colors.black38),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Center(
                    child: GestureDetector(
                      onTap: onAddActivities,
                      child: Container(
                        height: 40,
                        width: 180,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCC300),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "SAVE",
                            style: GoogleFonts.anton(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DayPlanner()));
  }
}
