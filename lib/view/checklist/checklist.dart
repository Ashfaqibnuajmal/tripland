import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textcodetripland/controllers/checkllist_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/checklist/checklist_add.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_showdilog.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

class Checklists extends StatefulWidget {
  final String tripId;
  final Trip tripModel;
  const Checklists({super.key, required this.tripId, required this.tripModel});

  @override
  State<Checklists> createState() => _ChecklistsState();
}

class _ChecklistsState extends State<Checklists> {
  Map<int, bool> checkboxStates = {}; // Store checkbox states by index
  String filterType = 'All'; // Default filter is "All"

  @override
  void initState() {
    super.initState();
    getChecklist(widget.tripModel.id);
    loadCheckboxStates(); // Load saved checkbox states
  }

  Future<void> loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    final keys =
        prefs.getKeys().where((key) => key.startsWith(widget.tripModel.id));

    setState(() {
      checkboxStates = {
        for (var key in keys)
          int.parse(key.split("_")[1]): prefs.getBool(key) ?? false
      };
    });
  }

  Future<void> saveCheckboxState(String tripId, int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    String key =
        "${tripId}_$index"; // Unique key for each trip and checklist item
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Checklist",
        ctx: context,
        shouldNavigate: true,
        targetPage: NotchBar(),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.black87,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const Gap(10),
                        buildFilterOption('All', context),
                        buildFilterOption('Checked', context),
                        buildFilterOption('Unchecked', context),
                        const Gap(30),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: checklistNotifier,
          builder: (context, data, child) {
            List filteredData = filterChecklistData(data).toSet().toList();

            if (filteredData.isEmpty) {
              return const Center(
                child: Text(
                  "No checklist found",
                  style: CustomTextStyle.empty,
                ),
              );
            }

            return ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final checklist = filteredData[index];
                final actualIndex = data.indexOf(checklist); // Get actual index
                return ListTile(
                  title: GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => CustomDeleteDialog(
                          onDelete: () {
                            deleteChecklist(checklist);
                          },
                          title: 'Delete checklist?',
                          message:
                              "Are you sure you want to delete this checklist item?",
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.grey[50],
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(checklist.name ?? "NA",
                                  style: CustomTextStyle.textStyle4),
                            ),
                            Checkbox(
                              checkColor: Colors.blueAccent,
                              activeColor: Colors.grey[50],
                              value: checkboxStates[actualIndex] ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkboxStates[actualIndex] = value ?? false;
                                  saveCheckboxState(widget.tripModel.id,
                                      actualIndex, value ?? false);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChecklistAdd(
                  tripId: widget.tripId,
                ),
              ),
            );
          },
          backgroundColor: const Color(0xFFFCC300),
          elevation: 6.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const Icon(
            Icons.library_add_check_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    );
  }

  // Filter checklist data based on the selected filter type
  List filterChecklistData(List data) {
    if (filterType == 'All') {
      return data;
    } else if (filterType == 'Checked') {
      return data
          .where((item) => checkboxStates[data.indexOf(item)] ?? false)
          .toList();
    } else if (filterType == 'Unchecked') {
      return data
          .where((item) => !(checkboxStates[data.indexOf(item)] ?? false))
          .toList();
    }
    return [];
  }

  // Build filter options for the bottom sheet
  Widget buildFilterOption(String option, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: CustomContainer(
        color: Colors.white70,
        child: TextButton(
          onPressed: () {
            setState(() {
              filterType = option;
            });
            Navigator.pop(context); // Close the bottom sheet
          },
          child: Text(option, style: CustomTextStyle.textStyle4),
        ),
      ),
    );
  }
}
