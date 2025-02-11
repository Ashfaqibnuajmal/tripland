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
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  journalNotifier.notifyListeners();
}

// Fetches all journal entries from the database
Future<void> getAllJournal() async {
  log("Fetching all journal entries...");
  final journalDb = await Hive.openBox<Journal>("journal_db");
  journalNotifier.value.clear();
  journalNotifier.value.addAll(journalDb.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  journalNotifier.notifyListeners();
}

// Deletes a journal entry by index
Future<void> deleteJournal(int index) async {
  log("Deleting journal entry at index: $index...");
  final journalDb = await Hive.openBox<Journal>("journal_db");
  await journalDb.deleteAt(index);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  journalNotifier.notifyListeners();
  getAllJournal();
}

// Edits an existing journal entry at the specified index
Future<void> editJournal(int index, Journal value) async {
  log("Editing journal entry at index: $index...");
  final journalDb = await Hive.openBox<Journal>("journal_db");
  await journalDb.putAt(index, value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  journalNotifier.notifyListeners();
  getAllJournal();
}
