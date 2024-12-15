import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:textcodetripland/model/activities.dart';
import 'package:textcodetripland/model/expance.dart';
import 'package:textcodetripland/model/trip.dart';

import 'package:textcodetripland/view/intro_screen_1.dart';

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
      home: const IntroScreen1(),
    );
  }
}
