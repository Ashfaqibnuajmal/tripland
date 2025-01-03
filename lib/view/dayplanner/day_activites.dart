import 'package:flutter/material.dart';
import 'package:textcodetripland/controllers/activities_controlers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/widgets/custom_activity_card.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_showdilog.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class DayActivities extends StatefulWidget {
  const DayActivities({
    super.key,
    required this.indexofday,
    required this.tripdata,
  });
  final int indexofday;
  final Trip tripdata;

  @override
  State<DayActivities> createState() => _DayActivitiesState();
}

class _DayActivitiesState extends State<DayActivities> {
  final Map<int, bool> _switchStates = {};
  String get tripId => widget.tripdata.id;
  int get dayIndex => widget.indexofday;

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
    getAllActivities(widget.tripdata.id, widget.indexofday);
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

            final activitie = activities.toSet().toList();

            return ListView.builder(
              itemCount: activitie.length,
              itemBuilder: (context, index) {
                final activity = activitie[index];
                bool switchState = _switchStates[index] ?? false;

                return ActivityCard(
                  activity: activity,
                  switchState: switchState,
                  onSwitchChanged: (bool value) {
                    _saveSwitchStateByKey(index, value);
                  },
                  onDeletePressed: () {
                    showMenu(
                      color: Colors.white,
                      context: context,
                      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                      items: [
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline_rounded),
                              SizedBox(width: 9),
                              Text("Delete"),
                            ],
                          ),
                        )
                      ],
                    ).then((value) {
                      if (value == 'delete') {
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (ctx) => CustomDeleteDialog(
                            onDelete: () {
                              deleteActivities(
                                  activity.id, index, widget.tripdata.id);
                            },
                            title: 'Delete Activity?',
                            message:
                                "Do you really want to remove this activity from your trip?",
                          ),
                        );
                      }
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
