import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/trip.dart';
import 'package:textcodetripland/view/bottom_navigation2.dart';
import 'package:textcodetripland/view/trip_add.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  double _rating = 3.0;
  String? _selectedTripType;
  final List<String> tripType = [
    "All",
    "Solo",
    "Family",
    "Romantic",
    "Honeymoon",
    "Cultural",
    "Road Trip",
    "Luxury",
    "Backpacking",
    "Natural",
  ];
  @override
  void initState() {
    super.initState();
    getAllTrips();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: Column(
        children: [
          const Gap(20),
          searchBar(),
          const Gap(20),
          Expanded(
            child: ValueListenableBuilder<List<Trip>>(
              valueListenable: tripListNotifier,
              builder: (context, tripList, child) {
                final filteredTrips = tripList
                    .where((trip) =>
                        (_selectedTripType == null ||
                            _selectedTripType == "All" ||
                            trip.selectedTripType == _selectedTripType) &&
                        (trip.location?.toLowerCase().contains(
                                _searchController.text.trim().toLowerCase()) ??
                            false))
                    .toList();
                return tripCard(filteredTrips);
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "Tripland",
        style: GoogleFonts.anton(fontSize: 20),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => _showBottomSheetHome(context),
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TripAdd()),
            );
          },
          icon: const Icon(Icons.note_add_rounded),
        ),
      ],
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        height: 45,
        width: 340,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFCC300), width: 1),
          color: Colors.white12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.black54),
            suffixIcon: IconButton(
              onPressed: () {
                _searchController.clear();
              },
              icon: const Icon(
                Icons.cancel_rounded,
                size: 20,
                color: Colors.black,
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10, top: 10),
          ),
        ),
      ),
    );
  }

  Widget tripCard(List<Trip> filteredTrips) {
    return ListView.builder(
      itemCount: filteredTrips.length,
      itemBuilder: (context, index) {
        final data = filteredTrips[index];
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                Text(
                  data.location?.isNotEmpty ?? false
                      ? data.location![0].toUpperCase() +
                          data.location!.substring(1)
                      : '',
                  style: GoogleFonts.anton(
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 0.8,
                  ),
                )
              ],
            ),
            Container(
              height: 250,
              width: 350,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(data.imageFile ?? "NA"),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    maxRating: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotchBar2(
                            index: index,
                            location: data.location,
                            startDate: data.startDate,
                            endDate: data.endDate,
                            selectedNumberOfPeople: data.selectedNumberOfPeople,
                            selectedTripType: data.selectedTripType,
                            expance: data.expance,
                            imageFile: data.imageFile,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "See more",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  void _showBottomSheetHome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.7),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Gap(10),
                Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 10,
                  runSpacing: 10,
                  children: tripType.map((category) {
                    return ChoiceChip(
                      label: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: _selectedTripType == category,
                      onSelected: (isSelected) {
                        setState(() {
                          _selectedTripType = isSelected ? category : null;
                        });
                        Navigator.pop(context);
                      },
                      selectedColor: const Color(0xFFFCC300),
                      backgroundColor: Colors.white38,
                    );
                  }).toList(),
                ),
                const Gap(30),
              ],
            ),
          ),
        );
      },
    );
  }
}
