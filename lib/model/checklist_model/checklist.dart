import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

// Part directive for Hive to generate the adapter code
part 'checklist.g.dart';

// Defining a Hive type for Checklist class with a unique typeId
@HiveType(typeId: 6)
class Checklist {
  // Field for the checklist name with Hive annotation
  @HiveField(0)
  final String name;
  @HiveField(1)
  String tripId;
  @HiveField(2)
  String id;
  // Constructor to initialize the Checklist class with the provided name
  Checklist({
    required this.name,
    required this.tripId,
  }) : id = const Uuid().v4();
}
