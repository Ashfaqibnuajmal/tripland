import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/view/constants/custom_appbar.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';

import 'package:textcodetripland/view/dayplanner/day_activites.dart';
import 'package:textcodetripland/view/dayplanner/dayplan_add.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

class DayPlanner extends StatefulWidget {
  const DayPlanner({
    super.key,
  });

  @override
  State<DayPlanner> createState() => _DayPlannerState();
}

class _DayPlannerState extends State<DayPlanner> {
  List<List<String>> dailyPlans = [];
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
      appBar: CustomAppBar(
        title: "Day Planner",
        ctx: context,
        shouldNavigate: true,
        targetPage: NotchBar(),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(qoutes[currentIndex],
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.textStyle4),
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace with the actual number of days
              itemBuilder: (context, index) {
                final int dayNumber =
                    index + 1; // To display Day 1, Day 2, etc.

                return Padding(
                  padding: const EdgeInsets.all(10),
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
                                    builder: (context) => DayActivities(
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              child: Text("Day $dayNumber Plan",
                                  style: CustomTextStyle.textStyle4),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PlanYourDayAdd(),
                                  ),
                                );
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
