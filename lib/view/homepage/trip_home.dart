import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/controllers/activities_controlers.dart';
import 'package:textcodetripland/controllers/checkllist_controllers.dart';
import 'package:textcodetripland/controllers/expance_controllers.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/checklist/checklist.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_catagory_box.dart';
import 'package:textcodetripland/view/widgets/custom_triphome_card.dart';
import 'package:textcodetripland/view/dayplanner/day_planner.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';
import 'package:textcodetripland/view/expance/expance_home.dart';

// ignore: must_be_immutable
class TripHome extends StatefulWidget {
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? selectedNumberOfPeople;
  final String? selectedTripType;
  final Trip tripModel;
  final String? expance;
  final Uint8List? imageFile;
  final int index;

  const TripHome({
    super.key,
    required this.tripModel,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.selectedNumberOfPeople,
    required this.selectedTripType,
    required this.expance,
    required this.imageFile,
    required this.index,
  });

  @override
  State<TripHome> createState() => _TripHomeState();
}

class _TripHomeState extends State<TripHome> {
  @override
  void initState() {
    super.initState();
    getAllTrips();
    getAllExpance(widget.tripModel.id);
    getAllActivities(widget.tripModel.id, widget.index);
    getChecklist(widget.tripModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.location.toString(),
        ctx: context,
        shouldNavigate: true,
        targetPage: const NotchBar(),
      ),
      body: ValueListenableBuilder(
        valueListenable: tripListNotifier,
        builder: (context, tripData, child) {
          if (tripData.isEmpty) {
            return const Center(child: Text("No information available"));
          }

          return SingleChildScrollView(
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
                              builder: (context) => Checklists(
                                    tripId: widget.tripModel.id,
                                    tripModel: widget.tripModel,
                                  )));
                        }),
                    CategoryBox(
                        label: 'Day Planner',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DayPlanner(
                                    trip: widget.tripModel,
                                  )));
                        }),
                    CategoryBox(
                        label: 'Expense',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ExpanceHome(
                                    trip: widget.tripModel,
                                    tripId: widget.tripModel.id,
                                  )));
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TripHomeCard(
                    startDate: widget.startDate,
                    endDate: widget.endDate,
                    selectedNumberOfPeople: widget.selectedNumberOfPeople,
                    selectedTripType: widget.selectedTripType,
                    expance: widget.expance,
                    imageFile: widget.imageFile,
                    index: widget.index,
                    location: widget.location,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
