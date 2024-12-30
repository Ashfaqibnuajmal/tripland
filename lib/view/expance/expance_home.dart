import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:textcodetripland/controllers/expance_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/constants/custom_container.dart';
import 'package:textcodetripland/view/constants/custom_showdilog.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';
import 'package:textcodetripland/view/expance/expance_add.dart';

class ExpanceHome extends StatefulWidget {
  final String tripId;
  final Trip trip;
  const ExpanceHome({super.key, required this.trip, required this.tripId});

  @override
  // ignore: library_private_types_in_public_api
  _ExpanceHomeState createState() => _ExpanceHomeState();
}

class _ExpanceHomeState extends State<ExpanceHome> {
  @override
  void initState() {
    super.initState();
    getAllExpance(widget.trip.id);
  }

  @override
  Widget build(BuildContext context) {
    String totalAmountString =
        widget.trip.expance ?? '0'; // Default to '0' if null
    double totalAmount =
        double.tryParse(totalAmountString) ?? 0.0; // Convert to double

    // Calculate amount used dynamically
    double amountUsed = expanceNotifier.value.fold(
        0.0, (sum, expance) => sum + (double.tryParse(expance.price) ?? 0.0));

    double balance = totalAmount - amountUsed;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Budget: ₹${totalAmount.toStringAsFixed(2)}",
          style: CustomTextStyle.textStyle3.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpanceAdd(tripId: widget.tripId),
                ),
              );
              if (result == true) {
                getAllExpance(widget.trip.id);
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                                  getAllExpance(widget.trip.id);
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
          ),
        ),
      ),
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
