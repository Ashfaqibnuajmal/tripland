// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:textcodetripland/controllers/journal_controllers.dart';
// import 'package:textcodetripland/view/constants/custom_appbar.dart';
// import 'package:textcodetripland/view/constants/custom_textstyle.dart';

// class JournalView extends StatefulWidget {
//   final String? location;
//   final String? journal;
//   final String? selectedTripType;
//   final DateTime? date;
//   final int index;
//   final List<String>? imageFiles; // Changed to a list of image files
//   final String? time;

//   const JournalView({
//     super.key,
//     required this.date,
//     required this.imageFiles, // Accepting list of image files
//     required this.index,
//     required this.journal,
//     required this.location,
//     required this.time,
//     required this.selectedTripType,
//   });

//   @override
//   State<JournalView> createState() => _JournalViewState();
// }

// class _JournalViewState extends State<JournalView> {
//   @override
//   void initState() {
//     super.initState();
//     getAllJournal();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: widget.location != null && widget.location!.isNotEmpty
//             ? '${widget.location![0].toUpperCase()}${widget.location!.substring(1)}'
//             : 'No Location',
//         ctx: context,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   widget.date != null
//                       ? DateFormat('dd MMM yyyy').format(widget.date!)
//                       : 'N/A',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 Text(
//                   widget.time != null
//                       ? DateFormat('hh:mm a')
//                           .format(DateFormat('HH:mm').parse(widget.time!))
//                       : 'N/A',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             // Horizontal ListView for displaying multiple images
//             widget.imageFiles != null && widget.imageFiles!.isNotEmpty
//                 ? Container(
//                     height: 550,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: widget.imageFiles!.length,
//                         itemBuilder: (context, index) {
//                           final imagePath = widget.imageFiles![index];
//                           return Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.file(
//                                 File(imagePath),
//                                 fit: BoxFit.cover,
//                                 width: 360, // Adjust width as needed
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   )
//                 : const SizedBox(),
//             Text(widget.selectedTripType.toString(),
//                 style: CustomTextStyle.textStyle4),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Text(
//                 widget.journal.toString(),
//                 style: CustomTextStyle.textStyle6,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/journal_controllers.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import the carousel_slider package

class JournalView extends StatefulWidget {
  final String? location;
  final String? journal;
  final String? selectedTripType;
  final DateTime? date;
  final int index;
  final List<String>? imageFiles; // Changed to a list of image files
  final String? time;

  const JournalView({
    super.key,
    required this.date,
    required this.imageFiles, // Accepting list of image files
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
  void initState() {
    super.initState();
    getAllJournal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.location != null && widget.location!.isNotEmpty
            ? '${widget.location![0].toUpperCase()}${widget.location!.substring(1)}'
            : 'No Location',
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
                      ? DateFormat('dd MMM yyyy').format(widget.date!)
                      : 'N/A',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  widget.time != null
                      ? DateFormat('hh:mm a')
                          .format(DateFormat('HH:mm').parse(widget.time!))
                      : 'N/A',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const Gap(20),
            // Using CarouselSlider for displaying images
            widget.imageFiles != null && widget.imageFiles!.isNotEmpty
                ? Container(
                    height: 550,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 550,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          animateToClosest: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                        ),
                        items: widget.imageFiles!.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(imagePath),
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : const SizedBox(),
            const Gap(10),
            Text(widget.selectedTripType.toString(),
                style: CustomTextStyle.textStyle4),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.journal.toString(),
                style: CustomTextStyle.textStyle6,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
