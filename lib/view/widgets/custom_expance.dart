import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:textcodetripland/model/expance_model/expance.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/widgets/custom_showdilog.dart';
import 'package:gap/gap.dart';

class ExpenseSummary extends StatelessWidget {
  final double amountUsed;
  final double balance;
  final ValueNotifier<List<Expance>> expanceNotifier;
  final Function deleteExpance;
  final Function getAllExpance;
  final String tripId;

  const ExpenseSummary({
    super.key,
    required this.amountUsed,
    required this.balance,
    required this.expanceNotifier,
    required this.deleteExpance,
    required this.getAllExpance,
    required this.tripId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          height: 200,
          color: Colors.white,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                    value: amountUsed,
                    title: 'Used',
                    color: Colors.red,
                    radius: 60,
                    titleStyle: CustomTextStyle.expense),
                PieChartSectionData(
                    value: balance < 0 ? 0 : balance,
                    title: 'Balance',
                    color: Colors.green,
                    radius: 60,
                    titleStyle: CustomTextStyle.expense),
              ],
              sectionsSpace: 4,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLegend("₹${amountUsed.toStringAsFixed(2)}", Colors.red),
            const Gap(20),
            _buildLegend("₹${balance.toStringAsFixed(2)}", Colors.green),
          ],
        ),
        const Gap(30),
        const CustomContainer(
          width: 400,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Items", style: CustomTextStyle.textStyle7),
                Text("Date", style: CustomTextStyle.textStyle7),
                Text("Price", style: CustomTextStyle.textStyle7),
              ],
            ),
          ),
        ),
        const Gap(10),
        SizedBox(
          height: 350,
          child: ValueListenableBuilder(
            valueListenable: expanceNotifier,
            builder: (context, expances, child) {
              if (expances.isEmpty) {
                return const Center(
                  child: Text(
                    "No expenses found",
                    style: CustomTextStyle.empty,
                  ),
                );
              }
              final uniqueExpances = expances.toSet().toList();
              return ListView.builder(
                itemCount: uniqueExpances.length,
                itemBuilder: (context, index) {
                  final expance = uniqueExpances[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expance.name,
                          style: CustomTextStyle.textStyle5,
                        ),
                        Text(
                          expance.date,
                          style: CustomTextStyle.textStyle6,
                        ),
                        Text(
                          "₹${expance.price}",
                          style: CustomTextStyle.textStyle5,
                        ),
                      ],
                    ),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => CustomDeleteDialog(
                          onDelete: () {
                            deleteExpance(expance);
                            getAllExpance(tripId);
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
      ],
    );
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
          style: CustomTextStyle.textStyle3.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
