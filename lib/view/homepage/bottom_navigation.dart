import 'package:flutter/material.dart';
import 'package:textcodetripland/view/bucketlist/bucketlist_view.dart';
import 'package:textcodetripland/view/homepage/home_page.dart';
import 'package:textcodetripland/view/journal/journal_home.dart';

class NotchBar extends StatefulWidget {
  const NotchBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotchBarState createState() => _NotchBarState();
}

class _NotchBarState extends State<NotchBar> {
  int _currentIndex = 1; // Set default index to 1 (Home Page)

  // Define the pages for each tab
  final List<Widget> _pages = [
    const JournalHome(),
    const HomePage(),
    const Bucketlist(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _currentIndex, // Set the current index for the selected tab
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
        backgroundColor:
            Colors.white, // Set bottom navigation bar color to white
        selectedItemColor: Colors
            .black, // Set the color of the selected icon and label to black
        unselectedItemColor: Colors
            .black, // Set the color of the unselected icon and label to black
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_rounded,
            ),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_travel_rounded,
            ),
            label: 'Bucket',
          ),
        ],
      ),
    );
  }
}
