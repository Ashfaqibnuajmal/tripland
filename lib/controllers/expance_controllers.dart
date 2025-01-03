import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/expance_model/expance.dart';

// add expance based on id
ValueNotifier<List<Expance>> expanceNotifier = ValueNotifier([]);
Future<void> addExpance(Expance value) async {
  log(" add the expance....");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  await expanceDb.put(value.id, value);
  getAllExpance(value.tripId);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expanceNotifier.notifyListeners();
}

// getallexpance  based on in tripId
Future<void> getAllExpance(String tripId) async {
  log("getallexpances......");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  expanceNotifier.value.clear();
  List<Expance> filteredExpance =
      expanceDb.values.where((expance) => expance.tripId == tripId).toList();
  expanceNotifier.value.addAll(filteredExpance);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expanceNotifier.notifyListeners();
  for (var expance in filteredExpance) {
    print("Item name = ${expance.name}");
    print("Item trip id = ${expance.tripId}");
  }
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expanceNotifier.notifyListeners();
}

// delete the expance from the id
Future<void> deleteExpance(Expance expance) async {
  log("delete the expance.....");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  await expanceDb.delete(expance.id);
  getAllExpance(expance.tripId);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expanceNotifier.notifyListeners();
}
