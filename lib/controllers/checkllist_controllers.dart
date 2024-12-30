import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/checklist_model/checklist.dart';

ValueNotifier<List<Checklist>> checklistNotifier = ValueNotifier([]);
Future<void> addChecklist(Checklist value) async {
  log("add checklist....");
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  await checklistDb.put(value.id, value);
  await getChecklist(value.tripId);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  checklistNotifier.notifyListeners();
}

Future<void> getChecklist(String tripId) async {
  log("getall checklist.....");
  final cheklistDb = await Hive.openBox<Checklist>("checklist_db");
  checklistNotifier.value.clear();
  List<Checklist> filteredChecklist = cheklistDb.values
      .where((checklist) => checklist.tripId == tripId)
      .toList();
  checklistNotifier.value.addAll(filteredChecklist);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  checklistNotifier.notifyListeners();
  for (var checklist in filteredChecklist) {
    print("Item name = ${checklist.name}");
    print("Item trip id = ${checklist.tripId}");
  }
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  checklistNotifier.notifyListeners();
}

Future<void> deleteChecklist(Checklist checklist) async {
  log("delete the checklsit...");
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  await checklistDb.delete(checklist.id);
  getChecklist(checklist.tripId);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  checklistNotifier.notifyListeners();
}
