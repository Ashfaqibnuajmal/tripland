import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/controllers/journal_controllers.dart';
import 'package:textcodetripland/view/widgets/custom_action.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_journal_gridview.dart';
import 'package:textcodetripland/view/journal/journal_add.dart';
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
                return JournalGridView(
                  journals: journals,
                  deleteJournal: deleteJournal,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
