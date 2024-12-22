import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/journal_controllers.dart';
import 'package:textcodetripland/view/journal_add.dart';
import 'package:textcodetripland/view/journal_edit.dart';
import 'package:textcodetripland/view/journal_view.dart';
import 'package:textcodetripland/view/proifle_page.dart';

class JournalHome extends StatefulWidget {
  const JournalHome({super.key});

  @override
  State<JournalHome> createState() => _JournalHomeState();
}

class _JournalHomeState extends State<JournalHome> {
  @override
  void initState() {
    super.initState();
    getAllJournal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Moments Capture",
          style: GoogleFonts.anton(
            fontSize: 20,
            shadows: const [
              Shadow(color: Colors.black12, offset: Offset(4, 4)),
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
          icon: const Icon(Icons.settings),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JournalAdd()),
              );
            },
            icon: const Icon(Icons.note_add_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          const Gap(10),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: journalNotifier,
              builder: (context, journals, child) {
                if (journals.isEmpty) {
                  return const Center(
                    child: Text("No activities found, try to add one"),
                  );
                }
                return MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: journals.length,
                  itemBuilder: (context, index) {
                    final data = journals[index];
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onLongPress: () {
                          showMenu(
                            color: Colors.white,
                            context: context,
                            position:
                                const RelativeRect.fromLTRB(100, 100, 0, 0),
                            items: [
                              const PopupMenuItem(
                                value: "edit",
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_calendar_rounded),
                                    SizedBox(width: 8),
                                    Text("Edit"),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_outline_rounded),
                                    SizedBox(width: 9),
                                    Text("Delete"),
                                  ],
                                ),
                              ),
                            ],
                          ).then((value) {
                            if (value == 'edit') {
                              Navigator.push(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JournalEdit(
                                          date: data.date,
                                          imageFile: data.imageFile,
                                          index: index,
                                          journal: data.journal,
                                          location: data.location,
                                          time: data.time,
                                          selectedTripType:
                                              data.selectedTripType)));
                            } else if (value == 'delete') {
                              showDialog(
                                // ignore: use_build_context_synchronously
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
                                        const Icon(
                                            Icons.report_gmailerrorred_outlined,
                                            size: 30,
                                            color: Colors.redAccent),
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                  deleteJournal(index);
                                                  Navigator.pop(context);
                                                },
                                                // You can link the function here
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                            }
                          });
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JournalView(
                                index: index,
                                location: data.location,
                                date: data.date,
                                journal: data.journal,
                                imageFile: data.imageFile,
                                time: data.time,
                                selectedTripType: data.selectedTripType,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(data.imageFile ?? "NA"),
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      ),
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
}
