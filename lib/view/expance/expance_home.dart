import 'package:flutter/material.dart';
import 'package:textcodetripland/controllers/expance_controllers.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/widgets/custom_expance.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
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
          child: ExpenseSummary(
            amountUsed: amountUsed,
            balance: balance,
            expanceNotifier: expanceNotifier,
            deleteExpance: deleteExpance,
            getAllExpance: getAllExpance,
            tripId: widget.tripId,
          ),
        ),
      ),
    );
  }
}
