import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/controllers/expance_controllers.dart';
import 'package:textcodetripland/view/constants/custom_showdilog.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/expance/expance_add.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

class ExpanceHome extends StatefulWidget {
  ExpanceHome({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ExpanceHomeState createState() => _ExpanceHomeState();
}

class _ExpanceHomeState extends State<ExpanceHome> {
  double totalAmount = 2000;
  double amountUsed = 300;
  double balance = 700;

  @override
  void initState() {
    super.initState();
    getAllExpance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Expance", style: CustomTextStyle.headings),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NotchBar()));
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExpanceAdd()),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _getPieChartSections(),
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend('Total budget', Colors.blue),
                _buildLegend('Amount Used', Colors.red),
                _buildLegend('Balance', Colors.green),
              ],
            ),
            const Gap(40),
            Container(
              height: 40,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Items", style: CustomTextStyle.textStyle7),
                  Text("Date", style: CustomTextStyle.textStyle7),
                  Text("Price", style: CustomTextStyle.textStyle7),
                ],
              ),
            ),
            const Gap(10),
            SizedBox(
              height: 250,
              child: Expanded(
                child: ValueListenableBuilder(
                  valueListenable: expanceNotifier,
                  builder: (context, expances, child) {
                    if (expances.isEmpty) {
                      return const Center(
                        child: Text(
                          "No expense found",
                          style: CustomTextStyle.empty,
                        ),
                      );
                    }

                    // Remove duplicates and reverse the order
                    final uniqueExpances = expances.toSet().toList();

                    return ListView.builder(
                      itemCount: uniqueExpances.length,
                      itemBuilder: (context, index) {
                        final expance = uniqueExpances[index];
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(expance.name ?? "No Name",
                                  style: CustomTextStyle.textStyle5),
                              Text(expance.date ?? "No Date",
                                  style: CustomTextStyle.textStyle6),
                              Text(expance.price ?? "No Price",
                                  style: CustomTextStyle.textStyle5),
                            ],
                          ),
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => CustomDeleteDialog(
                                onDelete: () {
                                  deleteExpance(index);
                                },
                                title: 'Delete Expense?',
                                message:
                                    "Are you sure you want to delete this expense?",
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSections() {
    return [
      PieChartSectionData(
        value: totalAmount,
        color: Colors.blue,
        title: totalAmount.toString(),
        radius: 50,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      PieChartSectionData(
        value: amountUsed,
        color: Colors.red,
        title: amountUsed.toString(),
        radius: 75,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      PieChartSectionData(
          value: balance,
          color: Colors.green,
          title: balance.toString(),
          radius: 100,
          titleStyle: CustomTextStyle.textStyle7),
    ];
  }
}

Widget _buildLegend(String title, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
      ),
      const SizedBox(width: 8),
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );
}
