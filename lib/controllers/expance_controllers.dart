import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/expance_model/expance.dart';

ValueNotifier<List<Expance>> expanceNotifier = ValueNotifier([]);
Future<void> addExpance(Expance value) async {
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  await expanceDb.put(value.id, value);
  getAllExpance(value.tripId);
}

Future<void> getAllExpance(String tripId) async {
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  expanceNotifier.value.clear();
  List<Expance> filteredExpance =
      expanceDb.values.where((expance) => expance.tripId == tripId).toList();
  expanceNotifier.value.addAll(filteredExpance);
  expanceNotifier.notifyListeners();
  for (var expance in filteredExpance) {
    print("Item name = ${expance.name}");
    print("Item trip id = ${expance.tripId}");
  }
  expanceNotifier.notifyListeners();
}

Future<void> deleteExpance(Expance expance) async {
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  await expanceDb.delete(expance.id);
  getAllExpance(expance.tripId);
}
