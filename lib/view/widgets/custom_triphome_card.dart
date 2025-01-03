import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/homepage/edit_trip.dart';

class TripHomeCard extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? selectedNumberOfPeople;
  final String? selectedTripType;
  final String? expance;
  final Uint8List? imageFile;
  final int index;
  final String? location;

  const TripHomeCard({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.selectedNumberOfPeople,
    required this.selectedTripType,
    required this.expance,
    required this.imageFile,
    required this.index,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                        items: [
                          const PopupMenuItem(
                              value: "edit",
                              child: Row(
                                children: [
                                  Icon(Icons.edit_calendar_rounded),
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
                              index: index,
                              location: location,
                              selectedNumberOfPeople: selectedNumberOfPeople,
                              selectedTripType: selectedTripType,
                              expance: expance,
                              imageFile: imageFile,
                              startDate: startDate,
                              endDate: endDate,
                            ),
                          ),
                        );
                      }
                    });
                  },
                  icon: const Icon(Icons.more_vert_rounded))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  startDate != null
                      ? DateFormat('d MMMM yyyy').format(startDate!)
                      : 'N/A',
                  style: CustomTextStyle.textStyle5),
              Text(
                  endDate != null
                      ? DateFormat('d MMMM yyyy').format(endDate!)
                      : 'N/A',
                  style: CustomTextStyle.textStyle5),
            ],
          ),
          const Gap(20),
          Container(
            height: 450,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: imageFile == null
                ? const Center(child: Text("No image available"))
                : Image.memory(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.people, size: 25),
                  const Gap(5),
                  Text('$selectedNumberOfPeople Person',
                      style: CustomTextStyle.category),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.travel_explore_rounded, size: 25),
                  const Gap(5),
                  Text(selectedTripType.toString(),
                      style: CustomTextStyle.category),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.currency_rupee_rounded, size: 25),
                  const Gap(5),
                  Text(expance.toString(), style: CustomTextStyle.category),
                ],
              ),
            ],
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
