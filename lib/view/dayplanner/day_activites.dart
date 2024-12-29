import 'package:flutter/material.dart';
import 'package:textcodetripland/controllers/activities_controlers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';
import 'package:textcodetripland/view/constants/custom_showdilog.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';

class DayActivities extends StatefulWidget {
  const DayActivities({super.key, required this.index, required this.tripdata});
  final int index;
  final Trip tripdata;

  @override
  State<DayActivities> createState() => _DayActivitiesState();
}

class _DayActivitiesState extends State<DayActivities> {
  final Map<int, bool> _switchStates = {};
  String get tripId => widget.tripdata.id; // Use trip ID as a unique identifier
  int get dayIndex => widget.index; // Use day index to identify the day

  Future<void> _loadAllSwitchStates() async {
    final activities = activitiesNotifier.value;
    for (int activityIndex = 0;
        activityIndex < activities.length;
        activityIndex++) {
      String key =
          SharedPreferencesHelper.getUniqueKey(tripId, dayIndex, activityIndex);
      bool state = await SharedPreferencesHelper.getSwitchState(key);
      _switchStates[activityIndex] = state;
    }
    setState(() {});
  }

  Future<void> _saveSwitchStateByKey(int activityIndex, bool value) async {
    String key =
        SharedPreferencesHelper.getUniqueKey(tripId, dayIndex, activityIndex);
    await SharedPreferencesHelper.saveSwitchState(key, value);
    setState(() {
      _switchStates[activityIndex] = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllActivities(widget.tripdata.id, widget.index);
    _loadAllSwitchStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Day Activities",
        ctx: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: activitiesNotifier,
          builder: (context, activities, child) {
            if (activities.isEmpty) {
              return const Center(
                child: Text(
                  "No activities found, try to add one",
                  style: CustomTextStyle.empty,
                ),
              );
            }

            // Reverse the activities list to show the last added item first
            final activitie = activities.toSet().toList();

            return ListView.builder(
              itemCount: activitie.length,
              itemBuilder: (context, index) {
                final activity = activitie[index];
                bool switchState = _switchStates[index] ?? false;

                return ListTile(
                  title: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Activity Name
                              Text(activity.activity ?? "Unnamed Activity",
                                  style: CustomTextStyle.textStyle3),
                              const SizedBox(height: 8),
                              // Time
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                      "${activity.fromTime ?? 'No Start Time'} - ${activity.toTime ?? 'No End Time'}",
                                      style: CustomTextStyle.textStyle5),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Location
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16),
                                  const SizedBox(width: 8),
                                  Text(activity.place ?? "No Location",
                                      style: CustomTextStyle.textStyle5),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Transportation
                              Row(
                                children: [
                                  const Icon(Icons.directions_car, size: 16),
                                  const SizedBox(width: 8),
                                  Text(activity.vehicle ?? "No Vehicle",
                                      style: CustomTextStyle.textStyle5),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showMenu(
                                        color: Colors.white,
                                        context: context,
                                        position: const RelativeRect.fromLTRB(
                                            100, 100, 0, 0),
                                        items: [
                                          // const PopupMenuItem(
                                          //     value: "edit",
                                          //     child: Row(
                                          //       children: [
                                          //         Icon(
                                          //           Icons.edit_calendar_rounded,
                                          //         ),
                                          //         SizedBox(width: 8),
                                          //         Text("Edit"),
                                          //       ],
                                          //     )),
                                          const PopupMenuItem(
                                              value: 'delete',
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .delete_outline_rounded),
                                                  SizedBox(width: 9),
                                                  Text("Delete"),
                                                ],
                                              ))
                                        ]).then((value) {
                                      if (value == 'edit') {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => DayplanEdit(
                                        //       tripdata: widget.tripdata,
                                        //       indexofday: widget.index,
                                        //       activity: activity.activity,
                                        //       fromTime: activity.fromTime,
                                        //       index: index,
                                        //       place: activity.place,
                                        //       toTime: activity.toTime,
                                        //       vehicle: activity.vehicle,
                                        //     ),
                                        //   ),
                                        // ).then((updatedActivity) {
                                        //   if (updatedActivity != null) {
                                        //     // Handle the updated activity
                                        //     setState(() {
                                        //       // Update the local list or state
                                        //     });
                                        //   }
                                        // });
                                      } else if (value == 'delete') {
                                        showDialog(
                                            // ignore: use_build_context_synchronously
                                            context: context,
                                            builder: (ctx) =>
                                                CustomDeleteDialog(
                                                  onDelete: () {
                                                    deleteActivities(
                                                        activity.id,
                                                        index,
                                                        widget.tripdata.id);
                                                  },
                                                  title: 'Delete Activity?',
                                                  message:
                                                      "Do you really want to remove this activity from your trip?",
                                                ));
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.more_vert_rounded)),
                              const SizedBox(height: 30),
                              Switch(
                                activeColor: Colors.white,
                                activeTrackColor: Colors.blue,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey,
                                value: switchState,
                                onChanged: (bool value) {
                                  _saveSwitchStateByKey(index, value);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
