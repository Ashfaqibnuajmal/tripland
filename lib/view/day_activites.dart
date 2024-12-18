import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/activities_controlers.dart';

class DayActivities extends StatefulWidget {
  const DayActivities({super.key});

  @override
  State<DayActivities> createState() => _DayActivitiesState();
}

class _DayActivitiesState extends State<DayActivities> {
  final Map<int, bool> _switchStates = {};

  Future<void> _loadAllSwitchStates() async {
    final activities = activitiesNotifier.value;
    for (int index = 0; index < activities.length; index++) {
      String key = 'switchState_$index';
      bool state = await SharedPreferencesHelper.getSwitchStateByKey(key);
      _switchStates[index] = state;
    }
    setState(() {});
  }

  Future<void> _saveSwitchStateByKey(int index, bool value) async {
    String key = 'switchState_$index';
    await SharedPreferencesHelper.saveSwitchStateByKey(key, value);
    setState(() {
      _switchStates[index] = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllActivities();
    _loadAllSwitchStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Day Activities",
          style: GoogleFonts.anton(fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: activitiesNotifier,
          builder: (context, activities, child) {
            if (activities.isEmpty) {
              return const Center(
                child: Text("No activities found try to add one"),
              );
            }
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
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
                              Text(
                                activity.activity ?? "Ddddd",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
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
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Location
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16),
                                  const SizedBox(width: 8),
                                  Text(activity.place ?? "DDd",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Transportation
                              Row(
                                children: [
                                  const Icon(Icons.directions_car, size: 16),
                                  const SizedBox(width: 8),
                                  Text(activity.vehicle ?? "DD",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text("Delete Actitivity"),
                                            content: const Text(
                                                "Are you sure want to delete this activity?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel")),
                                              TextButton(
                                                  onPressed: () async {
                                                    await deleteActivities(
                                                        index);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Delete"))
                                            ],
                                          );
                                        });
                                  },
                                  icon:
                                      const Icon(Icons.delete_outline_rounded)),
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
                              )
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
