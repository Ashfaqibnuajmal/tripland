// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:textcodetripland/model/journal.dart';

// ValueNotifier<List<Journal>> journalNotifier = ValueNotifier([]);
// Future<void> addJournal(Journal value) async {
//   log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
//   final journalDb = await Hive.openBox<Journal>("journal_db");
//   await journalDb.add(value);
//   journalNotifier.value.add(value);
//   journalNotifier.notifyListeners();
// }

// Future<void> getAllJournal() async {
//   final journalDb = await Hive.openBox<Journal>("journal_db");
//   journalNotifier.value.clear();
//   journalNotifier.value.addAll(journalDb.values);
//   journalNotifier.notifyListeners();
// }

// Future<void> deleteJournal(int index) async {
//   final journalDb = await Hive.openBox<Journal>("journal_db");
//   await journalDb.deleteAt(index);
//   journalNotifier.notifyListeners();
//   getAllJournal();
// }

// Future<void> editJournal(int index, Journal value) async {
//   final journalDb = await Hive.openBox<Journal>("journal_db");
//   await journalDb.putAt(index, value);
//   journalNotifier.notifyListeners();
//   getAllJournal();
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/journal_model/journal.dart';

// Notifies UI about changes in the journal list
ValueNotifier<List<Journal>> journalNotifier = ValueNotifier([]);

// Adds a new journal entry to the database
Future<void> addJournal(Journal value) async {
  log("Adding a new journal entry...");
  final journalDb = await Hive.openBox<Journal>("journal_db");
  await journalDb.add(value);
  journalNotifier.value.add(value);
  journalNotifier.notifyListeners();
}

// Fetches all journal entries from the database
Future<void> getAllJournal() async {
  log("Fetching all journal entries...");
  final journalDb = await Hive.openBox<Journal>("journal_db");
  journalNotifier.value.clear();
  journalNotifier.value.addAll(journalDb.values);
  journalNotifier.notifyListeners();
}

// Deletes a journal entry by index
Future<void> deleteJournal(int index) async {
  log("Deleting journal entry at index: $index...");
  final journalDb = await Hive.openBox<Journal>("journal_db");
  await journalDb.deleteAt(index);
  journalNotifier.notifyListeners();
  getAllJournal();
}

// Edits an existing journal entry at the specified index
Future<void> editJournal(int index, Journal value) async {
  log("Editing journal entry at index: $index...");
  final journalDb = await Hive.openBox<Journal>("journal_db");
  await journalDb.putAt(index, value);
  journalNotifier.notifyListeners();
  getAllJournal();
}
