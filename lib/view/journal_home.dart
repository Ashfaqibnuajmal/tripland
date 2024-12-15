import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/view/delete_message.dart';
import 'package:textcodetripland/view/journal_add.dart';
import 'package:textcodetripland/view/journal_view.dart';
import 'package:textcodetripland/view/proifle_page.dart';

class JournalHome extends StatefulWidget {
  const JournalHome({super.key});

  @override
  State<JournalHome> createState() => _JournalHomeState();
}

class _JournalHomeState extends State<JournalHome> {
  void deleteItem() {
    print('Item deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              Text("Moments Capture", style: GoogleFonts.anton(fontSize: 20)),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: const Icon(Icons.person_pin_rounded),
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
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              searchBar(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    journalItem(),
                    journalItem(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    journalItem(),
                    journalItem(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    journalItem(),
                    journalItem(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget journalItem() {
    return Container(
      height: 220,
      width: 170,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "#Adventure",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFCC300),
            ),
          ),
          const SizedBox(height: 2),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JournalView(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/introimage2.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => showDeleteDialog(context, deleteItem),
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget searchBar() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      height: 45,
      width: 360,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFCC300), width: 1),
          color: Colors.black12.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.black54),
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded, size: 26)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10, top: 10)),
      ),
    ),
  );
}
