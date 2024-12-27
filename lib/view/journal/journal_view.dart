import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/journal_controllers.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';

class JournalView extends StatefulWidget {
  final String? location;
  final String? journal;
  final String? selectedTripType;
  final DateTime? date;
  final int index;
  final String? imageFile;
  final String? time;
  const JournalView({
    super.key,
    required this.date,
    required this.imageFile,
    required this.index,
    required this.journal,
    required this.location,
    required this.time,
    required this.selectedTripType,
  });

  @override
  State<JournalView> createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {
  @override
  @override
  void initState() {
    super.initState();
    getAllJournal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.location.toString(),
        ctx: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.date != null
                      ? DateFormat('dd MMM yyyy')
                          .format(widget.date!) // Change format here
                      : 'N/A',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  widget.time != null
                      ? DateFormat('hh:mm a').format(DateFormat('HH:mm')
                          .parse(widget.time!)) // Change time format here
                      : 'N/A',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
                height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(widget.imageFile ?? "NA"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Text(
              widget.selectedTripType.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.journal.toString(),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
