import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';

// Notifies UI about changes in the trip list
ValueNotifier<List<Trip>> tripListNotifier = ValueNotifier([]);

// Adds a new trip entry to the database
Future<void> addTrip(Trip value) async {
  log("Adding a new trip entry...");
  final tripDb = await Hive.openBox<Trip>("trip_db");
  await tripDb.add(value);
  tripListNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  tripListNotifier.notifyListeners();
}

// Fetches all trip entries from the database
Future<void> getAllTrips() async {
  log("Fetching all trip entries...");
  final tripDb = await Hive.openBox<Trip>("trip_db");
  tripListNotifier.value.clear();
  tripListNotifier.value.addAll(tripDb.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  tripListNotifier.notifyListeners();
}

// Deletes a trip entry by index
Future<void> deleteTrip(int index) async {
  log("Deleting trip entry at index: $index...");
  final tripDb = await Hive.openBox<Trip>("trip_db");
  await tripDb.deleteAt(index);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  tripListNotifier.notifyListeners();
  getAllTrips();
}

// Edits an existing trip entry at the specified index
Future<void> editTrip(int index, Trip value) async {
  log("Editing trip entry at index: $index...");
  final tripDb = await Hive.openBox<Trip>("trip_db");
  await tripDb.putAt(index, value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  tripListNotifier.notifyListeners();
  getAllTrips();
}
