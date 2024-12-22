import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:textcodetripland/model/activities_model/activities.dart';
import 'package:textcodetripland/model/bucket_model/bucket.dart';
import 'package:textcodetripland/model/checklist_model/checklist.dart';
import 'package:textcodetripland/model/expance_model/expance.dart';
import 'package:textcodetripland/model/journal_model/journal.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/model/user_model/user.dart';
import 'package:textcodetripland/view/settings/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TripAdapter().typeId)) {
    Hive.registerAdapter(TripAdapter());
  }
  if (!Hive.isAdapterRegistered(ExpanceAdapter().typeId)) {
    Hive.registerAdapter(ExpanceAdapter());
  }
  if (!Hive.isAdapterRegistered(ActivitiesAdapter().typeId)) {
    Hive.registerAdapter(ActivitiesAdapter());
  }
  if (!Hive.isAdapterRegistered(BucketAdapter().typeId)) {
    Hive.registerAdapter(BucketAdapter());
  }
  if (!Hive.isAdapterRegistered(JournalAdapter().typeId)) {
    Hive.registerAdapter(JournalAdapter());
  }
  if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
    Hive.registerAdapter(UserAdapter());
  }
  if (!Hive.isAdapterRegistered(ChecklistAdapter().typeId)) {
    Hive.registerAdapter(ChecklistAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tripland',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen());
  }
}
