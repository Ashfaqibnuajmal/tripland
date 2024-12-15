import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:textcodetripland/view/checklist.dart';
import 'package:textcodetripland/view/day_planner.dart';
import 'package:textcodetripland/view/edit_trip.dart';
import 'package:textcodetripland/view/expance_home.dart';
import 'package:textcodetripland/view/trip_home.dart';

// ignore: must_be_immutable
class NotchBar2 extends StatefulWidget {
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? selectedNumberOfPeople;
  final String? selectedTripType;
  final String? expance;
  final String? imageFile;
  int index;

  NotchBar2({
    super.key,
    required this.index,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.selectedNumberOfPeople,
    required this.selectedTripType,
    required this.expance,
    required this.imageFile,
  });

  @override
  NotchBarState createState() => NotchBarState();
}

class NotchBarState extends State<NotchBar2> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 2);

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const Checklist(),
      const DayPlanner(),
      TripHome(
        location: widget.location,
        startDate: widget.startDate,
        endDate: widget.endDate,
        selectedNumberOfPeople: widget.selectedNumberOfPeople,
        selectedTripType: widget.selectedTripType,
        expance: widget.expance,
        imageFile: widget.imageFile,
      ),
      ExpanceHome(),
      TripEdit(
        index: widget.index,
        location: widget.location,
        selectedNumberOfPeople: widget.selectedNumberOfPeople,
        selectedTripType: widget.selectedTripType,
        expance: widget.expance,
        imageFile: widget.imageFile,
        startDate: widget.startDate,
        endDate: widget.endDate,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_controller.index],
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarWidth: MediaQuery.of(context).size.width,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.check_box_rounded, size: 25),
            activeItem: Icon(Icons.check_box_rounded, size: 25),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.done_all_sharp, size: 25),
            activeItem: Icon(Icons.done_all_sharp, size: 25),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.house_rounded, size: 25),
            activeItem: Icon(Icons.house_rounded, size: 25),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.currency_rupee_rounded, size: 25),
            activeItem: Icon(Icons.currency_rupee_rounded, size: 25),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.edit_calendar_rounded, size: 25),
            activeItem: Icon(Icons.edit_calendar_rounded, size: 25),
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
