import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/view/bottom_navigation.dart';

// ignore: must_be_immutable
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
      appBar: appBar(
        context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(10),
            dateRow(),
            imageContainer(),
            const Gap(20),
            infoRow(),
          ],
        ),
      ),
    );
  }

  AppBar appBar(
    BuildContext context,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(widget.location.toString()),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded, size: 25),
      ),
      actions: [
        ValueListenableBuilder(
          valueListenable: tripListNotifier,
          builder: (context, value, child) {
            return IconButton(
              onPressed: () {
                if (value.isNotEmpty) {
                  showDeleteDialog(context, 0);
                }
              },
              icon: const Icon(Icons.delete_outline_rounded, size: 25),
            );
          },
        ),
      ],
    );
  }

  Widget dateRow() {
    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (context, date, child) {
        return date.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    date.first.startDate != null
                        ? DateFormat('dd MMM yyyy	').format(widget.startDate!)
                        : 'N/A',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    date.first.endDate != null
                        ? DateFormat('dd MMM yyyy	').format(widget.endDate!)
                        : 'N/A',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              )
            : const Center(child: Text("No Dates Available"));
      },
    );
  }

  Widget imageContainer() {
    return Padding(
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
    );
  }

  Widget infoRow() {
    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (context, date, child) {
        return date.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoIconBox(
                    icon: Icons.people,
                    label: '${widget.selectedNumberOfPeople} Person',
                  ),
                  InfoIconBox(
                    icon: Icons.person_outline_rounded,
                    label: widget.selectedTripType.toString(),
                  ),
                  InfoIconBox(
                    icon: Icons.currency_rupee_rounded,
                    label: widget.expance.toString(),
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
    );
  }
}

class InfoIconBox extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoIconBox({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Icon(icon, size: 30),
          const Gap(5),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

Future<void> showDeleteDialog(BuildContext context, int index) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.black54,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.report_gmailerrorred_outlined,
                size: 30, color: Colors.red),
            const SizedBox(height: 10),
            const Text('Delete Trip?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const SizedBox(height: 10),
            const Text(
              'Are you sure you want to delete this Trip?',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(ctx, 'Cancel', Colors.white12, Colors.white,
                    () => Navigator.of(ctx).pop()),
                button(ctx, 'Delete', Colors.redAccent, Colors.white, () {
                  deleteTrip(index);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.redAccent,
                          ),
                          Text(
                            "Trip deleted! Memories live on.",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.black87,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const NotchBar()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget button(BuildContext ctx, String text, Color bgColor, Color textColor,
    VoidCallback onPressed) {
  return Container(
    height: 40,
    width: 90,
    decoration:
        BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(5)),
    child: TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    ),
  );
}
