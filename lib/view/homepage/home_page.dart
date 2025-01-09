import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/widgets/custom_action.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_bottomsheet.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/widgets/cutom_tripcard.dart';
import 'package:textcodetripland/view/homepage/trip_add.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedTripType;
  String _selectedDateFilter = "All";
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
  final List<String> dateFilters = ["All", "Upcoming", "Completed"];

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

  Future<double> getRatingForTrip(String tripKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(tripKey) ?? 3.0;
  }

  Future<void> saveRatingForTrip(String tripKey, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(tripKey, rating);
  }

  List<Trip> _getFilteredTrips(List<Trip> tripList) {
    final now = DateTime.now();

    final filteredList = tripList.where((trip) {
      final matchesType = _selectedTripType == null ||
          _selectedTripType == "All" ||
          trip.selectedTripType == _selectedTripType;

      final matchesSearch = trip.location
              ?.toLowerCase()
              .contains(_searchController.text.trim().toLowerCase()) ??
          false;

      final matchesDateFilter = _selectedDateFilter == "All" ||
          (_selectedDateFilter == "Upcoming" && trip.endDate!.isAfter(now)) ||
          (_selectedDateFilter == "Completed" && trip.endDate!.isBefore(now));

      return matchesType && matchesSearch && matchesDateFilter;
    }).toList();

    // Convert to Set to remove duplicates and back to List
    return filteredList.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Tripland  ",
        ctx: context,
        leading: IconButton(
          onPressed: () => _showBottomSheetHome(context),
          icon: const Icon(Icons.menu),
        ),
        actions: const [
          CustomAction(destinationPage: TripAdd()),
        ],
      ),
      body: Column(
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // Search Field
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFFFCC300), width: 1),
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
                        contentPadding:
                            const EdgeInsets.only(left: 10, top: 10),
                      ),
                    ),
                  ),
                ),
                // Date Filter Dropdown
                IconButton(
                  onPressed: () {
                    showMenu(
                      color: Colors.white,
                      context: context,
                      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                      items: [
                        const PopupMenuItem(
                          value: "All",
                          child: Text("All Trips"),
                        ),
                        const PopupMenuItem(
                          value: "Upcoming",
                          child: Text("Upcoming Trips"),
                        ),
                        const PopupMenuItem(
                          value: "Completed",
                          child: Text("Completed Trips"),
                        ),
                      ],
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _selectedDateFilter = value;
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.tune_rounded),
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
            child: ValueListenableBuilder<List<Trip>>(
              valueListenable: tripListNotifier,
              builder: (context, tripList, child) {
                final filteredTrips = _getFilteredTrips(tripList);
                return ListView.builder(
                  itemCount: filteredTrips.length,
                  itemBuilder: (context, index) {
                    final data = filteredTrips[index];
                    String tripKey = "rating_${data.location}";
                    return FutureBuilder<double>(
                      future: getRatingForTrip(tripKey),
                      builder: (context, snapshot) {
                        double rating = snapshot.data ?? 3.0;
                        return TripCard(
                          tripData: data,
                          index: index,
                          initialRating: rating,
                          saveRatingCallback: saveRatingForTrip,
                          onDelete: () => deleteTrip(index),
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
    BottomSheetWidget.showBottomSheetHome(
      context,
      tripType: tripType,
      selectedTripType: _selectedTripType,
      onTripTypeSelected: (selectedType) {
        setState(() {
          _selectedTripType = selectedType;
        });
      },
    );
  }
}
