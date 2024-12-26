import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/checklist_model/checklist.dart';

// Notifies UI about changes in the checklist
ValueNotifier<List<Checklist>> checklistNotifier = ValueNotifier([]);

// Adds a new checklist item to the database
Future<void> addChecklist(Checklist value) async {
  log("Adding a new checklist item...");
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  await checklistDb.add(value);
  checklistNotifier.value.add(value);
  checklistNotifier.notifyListeners();
}

// Fetches all checklist items from the database
Future<void> getAllChecklist() async {
  log("Fetching all checklist items...");
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  checklistNotifier.value.clear();
  checklistNotifier.value.addAll(checklistDb.values);
  checklistNotifier.notifyListeners();
}

// Deletes a checklist item by index
Future<void> deleteChecklist(int index) async {
  log("Deleting checklist item at index: $index...");
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  await checklistDb.deleteAt(index);
  checklistNotifier.notifyListeners();
  getAllChecklist();
}
