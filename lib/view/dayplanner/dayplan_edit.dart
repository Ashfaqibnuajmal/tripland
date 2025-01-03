// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:textcodetripland/controllers/activities_controlers.dart';
// import 'package:textcodetripland/model/activities_model/activities.dart';
// import 'package:textcodetripland/model/trip_model/trip.dart';
// import 'package:textcodetripland/view/constants/custom_appbar.dart';
// import 'package:textcodetripland/view/constants/custom_container.dart';
// import 'package:textcodetripland/view/constants/custom_textformfield.dart';
// import 'package:textcodetripland/view/constants/custom_textstyle.dart';
// import 'package:textcodetripland/view/constants/custombutton.dart';
// import 'package:textcodetripland/view/constants/customsnackbar.dart';

// // ignore: must_be_immutable
// class DayplanEdit extends StatefulWidget {
//   final String? activity;
//   final String? fromTime;
//   final String? toTime;
//   final String? place;
//   final Trip tripdata;
//   final int indexofday;
//   final String? vehicle;
//   final int index;

//   const DayplanEdit({
//     super.key,
//     required this.activity,
//     required this.indexofday,
//     required this.tripdata,
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
//   late TextEditingController _activitiesController;
//   late TextEditingController _placeController;
//   late TextEditingController _vehicleController;
//   String fromTime = "From Time";
//   String toTime = "To Time";

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with widget data
//     _activitiesController = TextEditingController(text: widget.activity);
//     _placeController = TextEditingController(text: widget.place);
//     _vehicleController = TextEditingController(text: widget.vehicle);

//     // Initialize time fields with widget data or defaults
//     fromTime = widget.fromTime ?? "From Time";
//     toTime = widget.toTime ?? "To Time";
//   }

//   @override
//   void dispose() {
//     // Dispose controllers to avoid memory leaks
//     _activitiesController.dispose();
//     _placeController.dispose();
//     _vehicleController.dispose();
//     super.dispose();
//   }

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

//     // Validation for empty fields
//     if (activity.isEmpty || place.isEmpty || vehicle.isEmpty) {
//       CustomSnackBar.show(
//         context: context,
//         message: "All fields are required!",
//         textColor: Colors.red,
//       );
//       return;
//     }

//     // Validation for time fields
//     if (fromTime == "From Time" || toTime == "To Time") {
//       CustomSnackBar.show(
//         context: context,
//         message: "Please select valid times!",
//         textColor: Colors.red,
//       );
//       return;
//     }

//     // Create updated activity object
//     final update = Activities(
//       tripid: widget.tripdata.id,
//       indexofday: widget.indexofday,
//       activity: activity,
//       fromTime: fromTime,
//       toTime: toTime,
//       place: place,
//       vehicle: vehicle,
//     );

//     // Call the editActivities function
//     await editActivities(
//         widget.tripdata.id, update, widget.tripdata.id, widget.index);

//     // Navigate back
//     // ignore: use_build_context_synchronously
//     Navigator.pop(context);
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
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Gap(40),
//                   const Text(
//                     "Enter Activity",
//                     style: CustomTextStyle.textStyle7,
//                   ),
//                   CustomContainer(
//                     color: Colors.white,
//                     child: CustomTextFormField(
//                       controller: _activitiesController,
//                       hintText: "Breakfast at hotel",
//                     ),
//                   ),
//                   const Gap(10),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
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
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                         onTap: () => selectedTime("From Time"),
//                         child: CustomContainer(
//                           width: 150,
//                           color: Colors.white,
//                           child: Center(
//                             child: Text(fromTime,
//                                 textAlign: TextAlign.center,
//                                 style: CustomTextStyle.textStyle6),
//                           ),
//                         ),
//                       ),
//                       const Gap(20),
//                       GestureDetector(
//                           onTap: () => selectedTime("To Time"),
//                           child: CustomContainer(
//                             width: 150,
//                             color: Colors.white,
//                             child: Center(
//                               child: Text(toTime,
//                                   textAlign: TextAlign.center,
//                                   style: CustomTextStyle.textStyle6),
//                             ),
//                           )),
//                     ],
//                   ),
//                   const Gap(10),
//                   const Text(
//                     "Locations",
//                     style: CustomTextStyle.textStyle7,
//                   ),
//                   CustomContainer(
//                     color: Colors.white,
//                     child: CustomTextFormField(
//                       controller: _placeController,
//                       hintText: "Delhi",
//                     ),
//                   ),
//                   const Gap(5),
//                   const Text(
//                     "Transportation",
//                     style: CustomTextStyle.textStyle7,
//                   ),
//                   CustomContainer(
//                     color: Colors.white,
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
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
