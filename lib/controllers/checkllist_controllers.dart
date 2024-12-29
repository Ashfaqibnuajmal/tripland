import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/checklist_model/checklist.dart';

ValueNotifier<List<Checklist>> checklistNotifier = ValueNotifier([]);
Future<void> addChecklist(Checklist value) async {
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  await checklistDb.put(value.id, value);
  await getChecklist(value.tripId);
}

Future<void> getChecklist(String tripId) async {
  final cheklistDb = await Hive.openBox<Checklist>("checklist_db");
  checklistNotifier.value.clear();
  List<Checklist> filteredChecklist = cheklistDb.values
      .where((checklist) => checklist.tripId == tripId)
      .toList();
  checklistNotifier.value.addAll(filteredChecklist);
  checklistNotifier.notifyListeners();
  for (var checklist in filteredChecklist) {
    print("Item name = ${checklist.name}");
    print("Item trip id = ${checklist.tripId}");
  }
  checklistNotifier.notifyListeners();
}

Future<void> deleteChecklist(Checklist checklist) async {
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  await checklistDb.delete(checklist.id);
  getChecklist(checklist.tripId);
}
