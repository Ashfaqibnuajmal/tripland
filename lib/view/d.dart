import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';

class TripHome extends StatefulWidget {
  String? location;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedNumberOfPeople;
  String? selectedTripType;
  String? expance;
  String? imageFile;
  TripHome({
    super.key,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.selectedNumberOfPeople,
    required this.selectedTripType,
    required this.expance,
    required this.imageFile,
  });

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
        title: Text(widget.location.toString()),
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
            const Gap(10),
            ValueListenableBuilder(
              valueListenable: tripListNotifier,
              builder: (context, date, child) {
                return date.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            date.first.startDate != null
                                ? DateFormat('dd MMM yyyy	')
                                    .format(widget.startDate!)
                                : 'N/A',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            date.first.endDate != null
                                ? DateFormat('dd MMM yyyy	')
                                    .format(widget.endDate!)
                                : 'N/A',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      )
                    : const Center(child: Text("No Dates Available"));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ValueListenableBuilder(
                valueListenable: tripListNotifier,
                builder: (context, image, child) {
                  if (image.isEmpty) {
                    return const Center(
                      child: Text(
                        "No image available",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 450,
                    width: double.infinity,
                    child: Image.file(File(widget.imageFile ?? 'NA')),
                  );
                },
              ),
            ),
            const Gap(20),
            ValueListenableBuilder(
              valueListenable: tripListNotifier,
              builder: (context, date, child) {
                return date.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCC300),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.people, size: 30),
                                const Gap(5),
                                Text(
                                  '${widget.selectedNumberOfPeople} Person',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCC300),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person_outline_rounded,
                                    size: 30),
                                const Gap(5),
                                Text(
                                  widget.selectedTripType.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCC300),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.currency_rupee_rounded,
                                    size: 30),
                                const Gap(5),
                                Text(
                                  widget.expance.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "No information available",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
