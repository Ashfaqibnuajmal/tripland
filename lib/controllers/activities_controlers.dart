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
  final activitiesDb = await Hive.openBox<Activities>("activities_db");
  await activitiesDb.add(value);
  activitiesNotifier.value.add(value);
  activitiesNotifier.notifyListeners();
}

// Fetches all activities from the database
Future<void> getAllActivities() async {
  log("Fetching activities...");
  final activitiesDb = await Hive.openBox<Activities>("activities_db");
  activitiesNotifier.value.clear();
  activitiesNotifier.value.addAll(activitiesDb.values);
  activitiesNotifier.notifyListeners();
}

// Edits an activity in the database
Future<void> editActivites(int index, Activities value) async {
  final activitiesDb = await Hive.openBox<Activities>("activities_db");
  await activitiesDb.deleteAt(index);
  activitiesNotifier.notifyListeners();
  await getAllActivities();
}

// Deletes an activity from the database
Future<void> deleteActivities(int index) async {
  log("Deleting activity...");
  final activitiesDb = await Hive.openBox<Activities>("activities_db");
  await activitiesDb.deleteAt(index);
  await getAllActivities();
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
