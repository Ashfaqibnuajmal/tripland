import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textcodetripland/model/activities_model/activities.dart';

// Notifies UI about changes in activities
ValueNotifier<List<Activities>> activitiesNotifier = ValueNotifier([]);

// Adds a new activity to the database
Future<void> addActivities(Activities value) async {
  log("Adding activity...");
  final activitiesDb = await Hive.openBox("activities_db");
  await activitiesDb.put(value.id, value);
  activitiesNotifier.notifyListeners();
}

// getAllActivities
Future<void> getAllActivities(String tripId, int indexOfDay) async {
  log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  final activitiesDb = await Hive.openBox("activities_db");

  // Get all plans from the Hive box
  final allPlans = activitiesDb.values.toList().cast<Activities>();

  // Filter the plans by tripId and indexOfDay
  List<Activities> filteredPlans = allPlans.where((plan) {
    return plan.tripid == tripId && plan.indexofday == indexOfDay;
  }).toList();

  // Update the notifier list with the filtered plans
  activitiesNotifier.value = filteredPlans;
  activitiesNotifier.notifyListeners();
}

// Deletes an activity from the database
Future<void> deleteActivities(
    String DayplanId, int indexOfDay, String tripId) async {
  final activitiesDb = await Hive.openBox("activities_db");

  // Log current keys before checking
  log('Current Daily Plans Keys: ${activitiesDb.keys.toList()}',
      name: 'Daily Plan Logger');

  // Check if the plan exists before attempting to delete
  final exists = activitiesDb.containsKey(DayplanId);

  if (exists) {
    await activitiesDb.delete(DayplanId);
    log('Deleted Daily Plan with ID: $DayplanId', name: 'Daily Plan Logger');

    await getAllActivities(tripId, indexOfDay);
  } else {
    log('No Daily Plan found with ID: $DayplanId', name: 'Daily Plan Logger');
  }

  // Optional: Log the current state of the database
  log('Current Daily Plans: ${activitiesDb.keys.toList()}',
      name: 'Daily Plan Logger');
}

// Handles switch state operations using SharedPreferences
class SharedPreferencesHelper {
  // Saves switch state by key
  static Future<void> saveSwitchStateByKey(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Retrieves switch state by key
  static Future<bool> getSwitchStateByKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
