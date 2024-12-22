import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/checklist.dart';

ValueNotifier<List<Checklist>> checklistNotifier = ValueNotifier([]);
Future<void> addChecklist(Checklist value) async {
  log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  await checklistDb.add(value);
  checklistNotifier.value.add(value);
  checklistNotifier.notifyListeners();
}

Future<void> getAllChecklist() async {
  log("sssssssss");
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  checklistNotifier.value.clear();
  checklistNotifier.value.addAll(checklistDb.values);
  checklistNotifier.notifyListeners();
}

Future<void> deleteChecklist(int index) async {
  final checklistDb = await Hive.openBox<Checklist>("checklist_db");
  await checklistDb.deleteAt(index);
  checklistNotifier.notifyListeners();
  getAllChecklist();
}
