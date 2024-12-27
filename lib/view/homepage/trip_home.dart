import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/view/checklist/checklist.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/dayplanner/day_planner.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';
import 'package:textcodetripland/view/homepage/edit_trip.dart';
import 'package:textcodetripland/view/expance/expance_home.dart';

// ignore: must_be_immutable
class TripHome extends StatefulWidget {
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? selectedNumberOfPeople;
  final String? selectedTripType;
  final String? expance;
  final String? imageFile;
  final int index;
  const TripHome(
      {super.key,
      required this.location,
      required this.startDate,
      required this.endDate,
      required this.selectedNumberOfPeople,
      required this.selectedTripType,
      required this.expance,
      required this.imageFile,
      required this.index});

  @override
  State<TripHome> createState() => _TripHomeState();
}

class _TripHomeState extends State<TripHome> {
  @override
  void initState() {
    super.initState();
    getAllTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.location.toString(),
          style: CustomTextStyle.headings,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NotchBar()));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryBox(
                    label: 'Checklist',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Checklists()));
                    }),
                CategoryBox(
                    label: 'Day Planner',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DayPlanner()));
                    }),
                CategoryBox(
                    label: 'Expense',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ExpanceHome()));
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              showMenu(
                                  color: Colors.white,
                                  context: context,
                                  position: const RelativeRect.fromLTRB(
                                      100, 100, 0, 0),
                                  items: [
                                    const PopupMenuItem(
                                        value: "edit",
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit_calendar_rounded,
                                            ),
                                            SizedBox(width: 8),
                                            Text("Edit"),
                                          ],
                                        )),
                                  ]).then((value) {
                                if (value == 'edit') {
                                  Navigator.push(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TripEdit(
                                                index: widget.index,
                                                location: widget.location,
                                                selectedNumberOfPeople: widget
                                                    .selectedNumberOfPeople,
                                                selectedTripType:
                                                    widget.selectedTripType,
                                                expance: widget.expance,
                                                imageFile: widget.imageFile,
                                                startDate: widget.startDate,
                                                endDate: widget.endDate,
                                              )));
                                }
                              });
                            },
                            icon: const Icon(Icons.more_vert_rounded))
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: tripListNotifier,
                      builder: (context, date, child) {
                        return date.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      date.first.startDate != null
                                          ? DateFormat('d MMMM yyyy')
                                              .format(widget.startDate!)
                                          : 'N/A',
                                      style: CustomTextStyle.textStyle5),
                                  Text(
                                    date.first.endDate != null
                                        ? DateFormat('d MMMM yyyy')
                                            .format(widget.endDate!)
                                        : 'N/A',
                                    style: CustomTextStyle.textStyle5,
                                  ),
                                ],
                              )
                            : const Center(child: Text("No Dates Available"));
                      },
                    ),
                    const Gap(20),
                    ValueListenableBuilder(
                      valueListenable: tripListNotifier,
                      builder: (context, image, child) {
                        if (image.isEmpty) {
                          return const Center(
                            child: Text(
                              "No image available",
                            ),
                          );
                        }
                        return Container(
                            height: 450,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                    File(widget.imageFile ?? 'NA'))));
                      },
                    ),
                    const Gap(10),
                    ValueListenableBuilder(
                      valueListenable: tripListNotifier,
                      builder: (context, date, child) {
                        return date.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.people,
                                            size: 25), // Smaller icon
                                        const Gap(5),
                                        Text(
                                            '${widget.selectedNumberOfPeople} Person',
                                            style: CustomTextStyle.category),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    width: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.travel_explore_rounded,
                                            size: 25),
                                        const Gap(5),
                                        Text(widget.selectedTripType.toString(),
                                            style: CustomTextStyle.category),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.currency_rupee_rounded,
                                            size: 25),
                                        const Gap(5),
                                        Text(widget.expance.toString(),
                                            style: CustomTextStyle.category),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const Center(
                                child: Text(
                                  "No information available",
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CategoryBox({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Light shadow color
              offset: const Offset(2, 4), // Standard, subtle offset
              blurRadius: 4, // Smooth blur for a subtle shadow effect
              spreadRadius: 0, // No spread, just a clean shadow
            ),
          ],
        ),
        child: Text(
          label,
          style: CustomTextStyle.category,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
