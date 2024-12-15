import 'dart:async'; // Correct Timer import
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/view/day_activites.dart';
import 'package:textcodetripland/view/dayplan_add.dart';

class DayPlanner extends StatefulWidget {
  const DayPlanner({super.key});

  @override
  State<DayPlanner> createState() => _DayPlannerState();
}

class _DayPlannerState extends State<DayPlanner> {
  final List<String> qoutes = [
    "Spend on memories, not just things; experiences last a lifetime.",
    "Invest in your happiness—plan wisely and cherish every moment.",
    "True wealth is found in the joy of living, not the cost of things.",
    "A day well spent is an investment in a lifetime of memories.",
    "Save smart, spend wisely, and create stories worth telling."
  ];

  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startQouteRotation();
  }

  void _startQouteRotation() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % qoutes.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int numberOfDays = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Day Planner",
          style: GoogleFonts.anton(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/dayPlan.png",
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Text(
                  qoutes[currentIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          for (int i = 1; i <= numberOfDays; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                color: const Color(0xFFFCC300),
                child: Container(
                  height: 50,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DayActivities()));
                          },
                          child: Text(
                            "Day $i Plan",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PlanYourDayAdd()));
                          },
                          icon: const Icon(
                            Icons.add_circle_outline_rounded,
                            size: 26,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
