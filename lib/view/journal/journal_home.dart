import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/controllers/journal_controllers.dart';
import 'package:textcodetripland/view/constants/custom_action.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';
import 'package:textcodetripland/view/constants/custom_showdilog.dart';
import 'package:textcodetripland/view/journal/journal_add.dart';
import 'package:textcodetripland/view/journal/journal_edit.dart';
import 'package:textcodetripland/view/journal/journal_view.dart';
import 'package:textcodetripland/view/settings/proifle_page.dart';

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
      appBar: CustomAppBar(
        title: "Journal",
        ctx: context,
        actions: const [
          CustomAction(destinationPage: JournalAdd()),
        ],
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
      ),
      body: Column(
        children: [
          const Gap(10),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: journalNotifier,
              builder: (context, journal, child) {
                final journals = journal.toSet().toList();
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
                    // Check if imageFiles is not null and not empty, then get the first image
                    String imagePath = (data.imageFiles != null &&
                            data.imageFiles!.isNotEmpty)
                        ? data.imageFiles![0]
                        : "NA"; // Default to "NA" if the list is null or empty

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
                                          imageFile: data.imageFiles!,
                                          index: index,
                                          journal: data.journal,
                                          location: data.location,
                                          time: data.time,
                                          selectedTripType:
                                              data.selectedTripType)));
                            } else if (value == 'delete') {
                              showDialog(
                                context: context,
                                builder: (ctx) => CustomDeleteDialog(
                                  onDelete: () {
                                    deleteJournal(index);
                                  },
                                  title: 'Delete Journal?',
                                  message:
                                      'Are you sure you want to delete this journal entry?',
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
                                imageFiles:
                                    data.imageFiles, // Pass the list here
                                time: data.time,
                                selectedTripType: data.selectedTripType,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(imagePath), // Use the first image path
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
