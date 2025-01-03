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
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  activitiesNotifier.notifyListeners();
}

// getAllActivities
Future<void> getAllActivities(String tripId, int indexOfDay) async {
  log("GetAll activites...");
  final activitiesDb = await Hive.openBox("activities_db");

  final allPlans = activitiesDb.values.toList().cast<Activities>();

  List<Activities> filteredPlans = allPlans.where((plan) {
    return plan.tripid == tripId && plan.indexofday == indexOfDay;
  }).toList();

  activitiesNotifier.value = filteredPlans;
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  activitiesNotifier.notifyListeners();
}

// Deletes an activity from the database
Future<void> deleteActivities(
    String dayplanId, int indexOfDay, String tripId) async {
  final activitiesDb = await Hive.openBox("activities_db");

  log('Current Daily Plans Keys: ${activitiesDb.keys.toList()}',
      name: 'Daily Plan Logger');

  final exists = activitiesDb.containsKey(dayplanId);

  if (exists) {
    await activitiesDb.delete(dayplanId);
    log('Deleted Daily Plan with ID: $dayplanId', name: 'Daily Plan Logger');

    await getAllActivities(tripId, indexOfDay);
  } else {
    log('No Daily Plan found with ID: $dayplanId', name: 'Daily Plan Logger');
  }

  log('Current Daily Plans: ${activitiesDb.keys.toList()}',
      name: 'Daily Plan Logger');
}

class SharedPreferencesHelper {
  // Generates a unique key for each activity based on day and index
  static String getUniqueKey(String tripId, int dayIndex, int activityIndex) {
    return 'switchState_${tripId}_day$dayIndex$activityIndex';
  }

  // Saves switch state
  static Future<void> saveSwitchState(String uniqueKey, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(uniqueKey, value);
  }

  // Retrieves switch state
  static Future<bool> getSwitchState(String uniqueKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(uniqueKey) ?? false;
  }
}
