// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:textcodetripland/controllers/trip_controllers.dart';
// import 'package:textcodetripland/model/bucket.dart';

// ValueNotifier<List<Bucket>> bucketNotifier = ValueNotifier([]);

// Future<void> addBucket(Bucket value) async {
//   log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
//   final bucketDb = await Hive.openBox<Bucket>("bucket_db");
//   await bucketDb.add(value);
//   bucketNotifier.value.add(value);
//   bucketNotifier.notifyListeners();
// }

// Future<void> getAllBucket() async {
//   log("gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
//   final bucketDb = await Hive.openBox<Bucket>("bucket_db");
//   bucketNotifier.value.clear();
//   bucketNotifier.value.addAll(bucketDb.values);
//   bucketNotifier.notifyListeners();
// }

// Future<void> deleteBucket(int index) async {
//   final bucketDb = await Hive.openBox<Bucket>("bucket_db");
//   await bucketDb.deleteAt(index);
//   bucketNotifier.notifyListeners();
//   await getAllBucket();
// }

// Future<void> editBucket(int index, Bucket value) async {
//   final bucketDb = await Hive.openBox<Bucket>("bucket_db");
//   await bucketDb.putAt(index, value);
//   bucketNotifier.notifyListeners();
//   await getAllBucket();
// }

// class SharedPreferencesHelper {
//   // Save the state of a specific switch using a unique key
//   static Future<void> saveSwitchStateByKey(String key, bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(key, value);
//   }

//   // Get the state of a specific switch using a unique key
//   static Future<bool> getSwitchStateByKey(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(key) ?? false; // Default to false
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textcodetripland/controllers/trip_controllers.dart';
import 'package:textcodetripland/model/bucket_model/bucket.dart';

// Notifies UI about changes in the bucket list
ValueNotifier<List<Bucket>> bucketNotifier = ValueNotifier([]);

// Adds a new bucket item to the database
Future<void> addBucket(Bucket value) async {
  log("Adding a new bucket item...");
  final bucketDb = await Hive.openBox<Bucket>("bucket_db");
  await bucketDb.add(value);
  bucketNotifier.value.add(value);
  bucketNotifier.notifyListeners();
}

// Fetches all bucket items from the database
Future<void> getAllBucket() async {
  log("Fetching all bucket items...");
  final bucketDb = await Hive.openBox<Bucket>("bucket_db");
  bucketNotifier.value.clear();
  bucketNotifier.value.addAll(bucketDb.values);
  bucketNotifier.notifyListeners();
}

// Deletes a bucket item by index
Future<void> deleteBucket(int index) async {
  log("Deleting bucket item at index: $index...");
  final bucketDb = await Hive.openBox<Bucket>("bucket_db");
  await bucketDb.deleteAt(index);
  bucketNotifier.notifyListeners();
  await getAllBucket();
}

// Edits an existing bucket item by index
Future<void> editBucket(int index, Bucket value) async {
  log("Editing bucket item at index: $index...");
  final bucketDb = await Hive.openBox<Bucket>("bucket_db");
  await bucketDb.putAt(index, value);
  bucketNotifier.notifyListeners();
  await getAllBucket();
}

// Handles switch state operations using SharedPreferences
class SharedPreferencesHelper {
  // Saves the state of a switch using a unique key
  static Future<void> saveSwitchStateByKey(String key, bool value) async {
    log("Saving switch state for key: $key...");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Retrieves the state of a switch using a unique key
  static Future<bool> getSwitchStateByKey(String key) async {
    log("Fetching switch state for key: $key...");
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false; // Default to false if key is not found
  }
}
