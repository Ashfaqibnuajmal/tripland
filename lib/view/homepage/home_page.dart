import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/constants/custom_showdilog.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/homepage/trip_add.dart';
import 'package:textcodetripland/view/homepage/trip_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
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

  // Function to get rating from SharedPreferences for a particular trip
  Future<double> getRatingForTrip(String tripKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(tripKey) ??
        3.0; // Default rating is 3.0 if not found
  }

  // Function to save rating to SharedPreferences for a particular trip
  Future<void> saveRatingForTrip(String tripKey, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(tripKey, rating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Trippy", style: CustomTextStyle.headings),
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
      ),
      body: Column(
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  hintText: "Search by location",
                  hintStyle: CustomTextStyle.search,
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
          ),
          const Gap(20),
          Expanded(
            child: ValueListenableBuilder<List<Trip>>(
              valueListenable: tripListNotifier,
              builder: (context, tripList, child) {
                final filteredTrip = tripList
                    .where((trip) =>
                        (_selectedTripType == null ||
                            _selectedTripType == "All" ||
                            trip.selectedTripType == _selectedTripType) &&
                        (trip.location?.toLowerCase().contains(
                                _searchController.text.trim().toLowerCase()) ??
                            false))
                    .toList();
                final filteredTrips = filteredTrip.toSet().toList();
                return ListView.builder(
                  itemCount: filteredTrips.length,
                  itemBuilder: (context, index) {
                    final data = filteredTrips[index];
                    String tripKey =
                        "rating_${data.location}"; // Unique key for each trip based on location
                    return FutureBuilder<double>(
                      future: getRatingForTrip(
                          tripKey), // Fetch rating for each trip
                      builder: (context, snapshot) {
                        double rating = snapshot.data ?? 3.0;
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
                                        : 'NA',
                                    style: CustomTextStyle.location)
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TripHome(
                                            index: index,
                                            location: data.location,
                                            startDate: data.startDate,
                                            endDate: data.endDate,
                                            selectedNumberOfPeople:
                                                data.selectedNumberOfPeople,
                                            selectedTripType:
                                                data.selectedTripType,
                                            expance: data.expance,
                                            imageFile: data.imageFile)));
                              },
                              child: GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => CustomDeleteDialog(
                                        onDelete: () {
                                          // Call your delete function here
                                          deleteTrip(index); // Example
                                        },
                                        title: 'Delete Itinerary?',
                                        message:
                                            "Do you want to delete this trip permanently?"),
                                  );
                                },
                                child: Container(
                                  height: 250,
                                  width: 350,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
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
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBar.builder(
                                    initialRating:
                                        rating, // Set the initial rating here
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
                                    onRatingUpdate: (newRating) {
                                      setState(() {
                                        saveRatingForTrip(tripKey,
                                            newRating); // Save rating when changed
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
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
