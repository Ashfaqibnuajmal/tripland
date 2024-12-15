import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textcodetripland/model/expance.dart';

ValueNotifier<List<Expance>> expanceNotifier = ValueNotifier([]);
Future<void> addExpance(Expance value) async {
  log("ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  await expanceDb.add(value);
  expanceNotifier.value.add(value);
  expanceNotifier.notifyListeners();
}

Future<void> getAllExpance() async {
  log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  expanceNotifier.value.clear();
  expanceNotifier.value.addAll(expanceDb.values);
  expanceNotifier.notifyListeners();
}

Future<void> deleteExpance(int index) async {
  log("sdssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
  final expanceDb = await Hive.openBox<Expance>("expance_db");
  await expanceDb.deleteAt(index);
  expanceNotifier.notifyListeners();
  getAllExpance();
}
