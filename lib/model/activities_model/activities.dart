import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
// This part directive is necessary for Hive to generate the adapter
part 'activities.g.dart';

// Defining a Hive type for Activities class with a unique typeId
@HiveType(typeId: 2)
class Activities {
  // Fields for the activity details
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

  @HiveField(5)
  final String tripid;

  @HiveField(6)
  final int indexofday;

  @HiveField(7)
  final String id;

  // Constructor to initialize the activity details
  Activities(
      {required this.activity,
      required this.fromTime,
      required this.toTime,
      required this.tripid,
      required this.indexofday,
      required this.place,
      required this.vehicle,
      String? id})
      : id = id ?? const Uuid().v4();
}
