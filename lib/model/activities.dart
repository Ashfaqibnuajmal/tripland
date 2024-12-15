import 'package:hive/hive.dart';

part 'activities.g.dart'; // This part directive is necessary for Hive to generate the adapter

@HiveType(typeId: 2)
class Activities {
  @HiveField(0)
  String? activity;

  @HiveField(1)
  String? fromTime;

  @HiveField(2)
  String? toTime;

  @HiveField(3)
  String? place;

  @HiveField(4)
  String? vehicle;

  Activities({
    required this.activity,
    required this.fromTime,
    required this.toTime,
    required this.place,
    required this.vehicle,
  });
}
