import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/activities.dart';

ValueNotifier<List<Activities>> activitiesNotifier = ValueNotifier([]);

Future<void> addActivities(Activities value) async {
  log("Adding activity to database...");
  final activitiesDb = await Hive.openBox<Activities>("activities_db");
  await activitiesDb.add(value);
  activitiesNotifier.value.add(value);
  activitiesNotifier.notifyListeners();
}

Future<void> getAllActivities() async {
  log("Fetching all activities from database...");
  final activitiesDb = await Hive.openBox<Activities>("activities_db");
  activitiesNotifier.value.clear();
  activitiesNotifier.value.addAll(activitiesDb.values);
  activitiesNotifier.notifyListeners();
}

Future<void> deleteActivities(int index) async {
  log("Deleting activity at index: $index...");
  final activitiesDb = await Hive.openBox<Activities>("activities_db");
  await activitiesDb.deleteAt(index);
  await getAllActivities();
}
