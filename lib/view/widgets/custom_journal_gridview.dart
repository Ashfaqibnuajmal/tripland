import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:textcodetripland/view/journal/journal_edit.dart';
import 'package:textcodetripland/view/journal/journal_view.dart';
import 'package:textcodetripland/view/widgets/custom_showdilog.dart';

class JournalGridView extends StatelessWidget {
  final List journals;
  final Function deleteJournal;

  const JournalGridView({
    Key? key,
    required this.journals,
    required this.deleteJournal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: journals.length,
      itemBuilder: (context, index) {
        final data = journals[index];
        String imagePath =
            (data.imageFiles != null && data.imageFiles!.isNotEmpty)
                ? data.imageFiles![0]
                : "NA"; // Default to "NA" if the list is null or empty

        return Padding(
          padding: const EdgeInsets.all(2),
          child: GestureDetector(
            onLongPress: () {
              showMenu(
                color: Colors.white,
                context: context,
                position: const RelativeRect.fromLTRB(100, 100, 0, 0),
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
                    context,
                    MaterialPageRoute(
                      builder: (context) => JournalEdit(
                        date: data.date,
                        imageFile: data.imageFiles!,
                        index: index,
                        journal: data.journal,
                        location: data.location,
                        time: data.time,
                        selectedTripType: data.selectedTripType,
                      ),
                    ),
                  );
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
                    imageFiles: data.imageFiles, // Pass the list here
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
  }
}
