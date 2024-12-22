import 'package:hive/hive.dart';

// Part directive for Hive to generate the adapter code
part 'checklist.g.dart';

// Defining a Hive type for Checklist class with a unique typeId
@HiveType(typeId: 6)
class Checklist {
  // Field for the checklist name with Hive annotation
  @HiveField(0)
  String? name;

  // Constructor to initialize the Checklist class with the provided name
  Checklist({
    required this.name,
  });
}
