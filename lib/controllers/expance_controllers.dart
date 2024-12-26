import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/expance_model/expance.dart';

// Notifies UI about changes in the expanse list
ValueNotifier<List<Expance>> expanceNotifier = ValueNotifier([]);

// Adds a new expense entry to the database
Future<void> addExpance(Expance value) async {
  log("Adding a new expense entry...");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  await expanceDb.add(value);
  expanceNotifier.value.add(value);
  expanceNotifier.notifyListeners();
}

// Fetches all expense entries from the database
Future<void> getAllExpance() async {
  log("Fetching all expense entries...");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  expanceNotifier.value.clear();
  expanceNotifier.value.addAll(expanceDb.values);
  expanceNotifier.notifyListeners();
}

// Deletes an expense entry by index
Future<void> deleteExpance(int index) async {
  log("Deleting expense entry at index: $index...");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  await expanceDb.deleteAt(index);
  expanceNotifier.notifyListeners();
  getAllExpance();
}
