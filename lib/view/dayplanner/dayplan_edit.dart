// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:textcodetripland/controllers/activities_controlers.dart';
// import 'package:textcodetripland/model/activities_model/activities.dart';
// import 'package:textcodetripland/view/constants/custom_appbar.dart';
// import 'package:textcodetripland/view/constants/custom_textformfield.dart';
// import 'package:textcodetripland/view/constants/custom_textstyle.dart';
// import 'package:textcodetripland/view/constants/custombutton.dart';
// import 'package:textcodetripland/view/constants/customsnackbar.dart';
// import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

// // ignore: must_be_immutable
// class DayplanEdit extends StatefulWidget {
//   String? activity;
//   String? fromTime;
//   String? toTime;
//   String? place;
//   String? vehicle;
//   int index;
//   DayplanEdit({
//     super.key,
//     required this.activity,
//     required this.fromTime,
//     required this.index,
//     required this.place,
//     required this.toTime,
//     required this.vehicle,
//   });
//   @override
//   State<DayplanEdit> createState() => _DayplanEditState();
// }

// class _DayplanEditState extends State<DayplanEdit> {
//   TextEditingController _activitiesController = TextEditingController();
//   TextEditingController _placeController = TextEditingController();
//   TextEditingController _vehicleController = TextEditingController();
//   String fromTime = "From Time";
//   String toTime = "To Time";

//   Future<void> selectedTime(String label) async {
//     TimeOfDay? selectedTime =
//         await showTimePicker(context: context, initialTime: TimeOfDay.now());
//     if (selectedTime != null) {
//       setState(() {
//         if (label == "From Time") {
//           fromTime = selectedTime.format(context);
//         } else {
//           toTime = selectedTime.format(context);
//         }
//       });
//     }
//   }

//   Future<void> _updateActivities() async {
//     final activity = _activitiesController.text;
//     final place = _placeController.text;
//     final vehicle = _vehicleController.text;
//     final startTime = fromTime; // Current value of fromTime
//     final endTime = toTime; // Current value of toTime
//     final update = Activities(
//         activity: activity,
//         fromTime: startTime,
//         toTime: endTime,
//         place: place,
//         vehicle: vehicle);
//     CustomSnackBar.show(
//         context: context,
//         message: "Bucket list trip editted! Adcenture awaits",
//         textColor: Colors.green);
//     editActivities(widget.index, update);
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => NotchBar()));
//   }

//   @override
//   void initState() {
//     super.initState();
//     _activitiesController = TextEditingController(text: widget.activity);
//     _placeController = TextEditingController(text: widget.place);
//     _vehicleController = TextEditingController(text: widget.vehicle);

//     // Initialize fromTime and toTime with widget values
//     fromTime = widget.fromTime ??
//         "From Time"; // Use default if widget.fromTime is null
//     toTime = widget.toTime ?? "To Time"; // Use default if widget.toTime is null
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: "Plan Your Day",
//         ctx: context,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             height: 500,
//             width: 360,
//             decoration: BoxDecoration(
//               color: Colors.black87,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Gap(40),
//                   Text("Enter Activity",
//                       style: GoogleFonts.anton(color: Colors.white)),
//                   Container(
//                     height: 50,
//                     width: 330,
//                     margin: const EdgeInsets.symmetric(vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: CustomTextFormField(
//                       controller: _activitiesController,
//                       hintText: "Breakfast at hotel",
//                     ),
//                   ),
//                   const Gap(10),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("From Time",
//                             style: GoogleFonts.roboto(color: Colors.white)),
//                         Text("To Time",
//                             style: GoogleFonts.roboto(color: Colors.white)),
//                       ],
//                     ),
//                   ),
//                   const Gap(5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () => selectedTime("From Time"),
//                         child: Container(
//                           height: 50,
//                           width: 150,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Center(
//                             child: Text(fromTime,
//                                 textAlign: TextAlign.center,
//                                 style: CustomTextStyle.textStyle6),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => selectedTime("To Time"),
//                         child: Container(
//                           height: 50,
//                           width: 150,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Center(
//                             child: Text(toTime,
//                                 textAlign: TextAlign.center,
//                                 style: CustomTextStyle.textStyle6),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Gap(10),
//                   Text("Locations",
//                       style: GoogleFonts.anton(color: Colors.white)),
//                   Container(
//                     height: 50,
//                     width: 330,
//                     margin: const EdgeInsets.symmetric(vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: CustomTextFormField(
//                       controller: _placeController,
//                       hintText: "Delhi",
//                     ),
//                   ),
//                   const Gap(5),
//                   Text("Transportation",
//                       style: GoogleFonts.anton(color: Colors.white)),
//                   Container(
//                     height: 50,
//                     width: 330,
//                     margin: const EdgeInsets.symmetric(vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: CustomTextFormField(
//                       controller: _vehicleController,
//                       hintText: "Car or Flight",
//                     ),
//                   ),
//                   const Gap(20),
//                   Center(
//                     child: Custombutton(
//                       text: "ADD ACTIVITIES",
//                       onPressed: _updateActivities,
//                       horizontalPadding: 10, // Custom horizontal padding
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/activities_controlers.dart';
import 'package:textcodetripland/model/activities_model/activities.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';
import 'package:textcodetripland/view/constants/custom_textformfield.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/constants/custombutton.dart';
import 'package:textcodetripland/view/constants/customsnackbar.dart';
import 'package:textcodetripland/view/dayplanner/day_activites.dart';
import 'package:textcodetripland/view/dayplanner/day_planner.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

// ignore: must_be_immutable
class DayplanEdit extends StatefulWidget {
  final String? activity;
  final String? fromTime;
  final String? toTime;
  final String? place;
  final String? vehicle;
  final int index;

  const DayplanEdit({
    super.key,
    required this.activity,
    required this.fromTime,
    required this.index,
    required this.place,
    required this.toTime,
    required this.vehicle,
  });

  @override
  State<DayplanEdit> createState() => _DayplanEditState();
}

class _DayplanEditState extends State<DayplanEdit> {
  late TextEditingController _activitiesController;
  late TextEditingController _placeController;
  late TextEditingController _vehicleController;
  String fromTime = "From Time";
  String toTime = "To Time";

  @override
  void initState() {
    super.initState();
    // Initialize controllers with widget data
    _activitiesController = TextEditingController(text: widget.activity);
    _placeController = TextEditingController(text: widget.place);
    _vehicleController = TextEditingController(text: widget.vehicle);

    // Initialize time fields with widget data or defaults
    fromTime = widget.fromTime ?? "From Time";
    toTime = widget.toTime ?? "To Time";
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _activitiesController.dispose();
    _placeController.dispose();
    _vehicleController.dispose();
    super.dispose();
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

  Future<void> _updateActivities() async {
    final activity = _activitiesController.text;
    final place = _placeController.text;
    final vehicle = _vehicleController.text;

    // Validation for empty fields
    if (activity.isEmpty || place.isEmpty || vehicle.isEmpty) {
      CustomSnackBar.show(
        context: context,
        message: "All fields are required!",
        textColor: Colors.red,
      );
      return;
    }

    final startTime = fromTime;
    final endTime = toTime;

    // Create updated activity object
    final update = Activities(
      activity: activity,
      fromTime: startTime,
      toTime: endTime,
      place: place,
      vehicle: vehicle,
    );

    editActivities(widget.index, update);

    // Navigate back to home
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DayPlanner()),
    );
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
                      onPressed: _updateActivities,
                      horizontalPadding: 10, // Custom horizontal padding
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
}
