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
  Map<int, bool> checkboxStates = {}; // Store checkbox states by index
  String filterType = 'All'; // Default filter is "All"

  @override
  void initState() {
    super.initState();
    getAllChecklist();
    loadCheckboxStates(); // Load saved checkbox states
  }

  // Load checkbox states from SharedPreferences
  Future<void> loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => int.tryParse(key) != null);

    setState(() {
      checkboxStates = {
        for (var key in keys) int.parse(key): prefs.getBool(key) ?? false
      };
    });
  }

  // Save checkbox state to SharedPreferences
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
            List filteredData = filterChecklistData(data);

            if (filteredData.isEmpty) {
              return const Center(
                child: Text("No checklist found"),
              );
            }

            return ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final checklist = filteredData[index];
                return ListTile(
                  title: GestureDetector(
                    onLongPress: () {},
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
                              value: checkboxStates[index] ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkboxStates[index] = value ?? false;
                                  saveCheckboxState(index, value ?? false);
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
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

  List filterChecklistData(List data) {
    if (filterType == 'All') {
      return data;
    } else if (filterType == 'Checked') {
      return data
          .asMap()
          .entries
          .where((entry) => checkboxStates[entry.key] ?? false)
          .map((entry) => entry.value)
          .toList();
    } else if (filterType == 'Unchecked') {
      return data
          .asMap()
          .entries
          .where((entry) => !(checkboxStates[entry.key] ?? false))
          .map((entry) => entry.value)
          .toList();
    }
    return [];
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
          Navigator.pop(context); // Close the bottom sheet
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
