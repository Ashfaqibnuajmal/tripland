import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'package:textcodetripland/view/bucketlist_view.dart';
import 'package:textcodetripland/view/home_page.dart';
import 'package:textcodetripland/view/journal_home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotchBar extends StatefulWidget {
  NotchBar({
    super.key,
  });

  @override
  NotchBarState createState() => NotchBarState();
}

class NotchBarState extends State<NotchBar> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 1);

  final List<Widget> _pages = [
    const JournalHome(),
    const HomePage(),
    Bucketlist(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: _pages[_controller.index],
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarWidth: MediaQuery.of(context).size.width,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.menu_book_rounded, size: 30),
            activeItem: Icon(Icons.menu_book_rounded, size: 30),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.home, size: 30),
            activeItem: Icon(Icons.home, size: 30),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.wallet_travel_rounded, size: 30),
            activeItem: Icon(Icons.wallet_travel_rounded, size: 30),
          ),
        ],
        onTap: (index) {
          setState(() {
            _controller.index = index;
          });
        },
        kIconSize: 30,
        kBottomRadius: 40,
        bottomBarHeight: 60,
        color: const Color.fromARGB(255, 229, 228, 228),
        notchColor: const Color(0xFFFCC300),
        shadowElevation: 5,
        showTopRadius: true,
      ),
    );
  }
}
