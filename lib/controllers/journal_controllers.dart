import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/journal.dart';

ValueNotifier<List<Journal>> journalNotifier = ValueNotifier([]);
Future<void> addJournal(Journal value) async {
  log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  final journalDb = await Hive.openBox<Journal>("journal_db");
  await journalDb.add(value);
  journalNotifier.value.add(value);
  journalNotifier.notifyListeners();
}

Future<void> getAllJournal() async {
  final journalDb = await Hive.openBox<Journal>("journal_db");
  journalNotifier.value.clear();
  journalNotifier.value.addAll(journalDb.values);
  journalNotifier.notifyListeners();
}

Future<void> deleteJournal(int index) async {
  final journalDb = await Hive.openBox<Journal>("journal_db");
  await journalDb.deleteAt(index);
  journalNotifier.notifyListeners();
  getAllJournal();
}

Future<void> editJournal(int index, Journal value) async {
  final journalDb = await Hive.openBox<Journal>("journal_db");
  await journalDb.putAt(index, value);
  journalNotifier.notifyListeners();
  getAllJournal();
}
