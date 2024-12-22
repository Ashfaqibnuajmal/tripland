import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textcodetripland/controllers/checkllist_controllers.dart';
import 'package:textcodetripland/view/checklist_add.dart';

class Checklists extends StatefulWidget {
  const Checklists({super.key});

  @override
  State<Checklists> createState() => _ChecklistsState();
}

class _ChecklistsState extends State<Checklists> {
  Map<int, bool> checkboxStates = {};

  @override
  void initState() {
    super.initState();
    getAllChecklist();
    loadCheckboxStates(); // Load states from SharedPreferences
  }

  String filterType = 'All'; // Default filter is "All"

  /// Load checkbox states from SharedPreferences
  Future<void> loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    setState(() {
      checkboxStates = {
        for (var key in keys) int.parse(key): prefs.getBool(key) ?? false
      };
    });
  }

  /// Save checkbox state to SharedPreferences
  Future<void> saveCheckboxState(int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(index.toString(), value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Checklist", style: GoogleFonts.anton(fontSize: 20)),
        centerTitle: true,
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
            // Filter data based on the filter type
            List filteredData = [];

            if (filterType == 'All') {
              filteredData = data;
            } else if (filterType == 'Checked') {
              filteredData = data.where((checklist) {
                int index = data.indexOf(checklist);
                return checkboxStates[index] ?? false; // Only checked items
              }).toList();
            } else if (filterType == 'Unchecked') {
              filteredData = data.where((checklist) {
                int index = data.indexOf(checklist);
                return !(checkboxStates[index] ??
                    false); // Only unchecked items
              }).toList();
            }

            if (filteredData.isEmpty) {
              return const Center(
                child: Text("No checklist found"),
              );
            }

            return ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final checklist = filteredData[index];
                int originalIndex = data.indexOf(checklist);
                return ListTile(
                  title: GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: Colors.black87,
                          contentPadding: EdgeInsets.zero,
                          content: Container(
                            width: 300,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.report_gmailerrorred_outlined,
                                    size: 30, color: Colors.redAccent),
                                const Gap(10),
                                const Text('Delete?',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                                const Gap(10),
                                const Text(
                                  "Are you sure you want to Delete?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Gap(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Cancel button
                                    Container(
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    // Logout button
                                    Container(
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextButton(
                                        onPressed: () {
                                          deleteChecklist(index);
                                          Navigator.pop(context);
                                        },
                                        // You can link the function here
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                              child: Text(
                                checklist.name ?? "NA",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Checkbox(
                              checkColor: Colors.blueAccent,
                              activeColor: Colors.grey[50],
                              value: checkboxStates[originalIndex] ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkboxStates[originalIndex] =
                                      value ?? false;
                                  saveCheckboxState(
                                      originalIndex, value ?? false);
                                });
                              },
                            ),
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
      ), // Replace your previous IconButton in the appBar actions with the following:
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            bottom: 40.0), // Adjust the bottom padding as needed
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChecklistAdd(),
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

  Widget buildFilterOption(String option, BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            filterType = option;
          });
          Navigator.pop(context); // Close bottom sheet
        },
        child: Text(
          option,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
