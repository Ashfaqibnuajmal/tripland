import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/trip.dart';

ValueNotifier<List<Trip>> tripListNotifier = ValueNotifier([]);
Future<void> addTrip(Trip value) async {
  final tripDb = await Hive.openBox<Trip>("trip_db");
  await tripDb.add(value);
  tripListNotifier.value.add(value);
  tripListNotifier.notifyListeners();
}

Future<void> getAllTrips() async {
  final tripDb = await Hive.openBox<Trip>("trip_db");
  tripListNotifier.value.clear();
  tripListNotifier.value.addAll(tripDb.values);
  tripListNotifier.notifyListeners();
}

Future<void> deleteTrip(int index) async {
  final tripDb = await Hive.openBox<Trip>("trip_db");
  await tripDb.deleteAt(index);
  tripListNotifier.notifyListeners();
  getAllTrips();
}

Future<void> editTrip(int index, Trip value) async {
  final tripDb = await Hive.openBox<Trip>("trip_db");
  await tripDb.putAt(index, value);
  tripListNotifier.notifyListeners();

  getAllTrips();
}
