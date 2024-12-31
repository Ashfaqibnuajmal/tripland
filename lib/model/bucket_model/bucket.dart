import 'dart:typed_data';

import 'package:hive/hive.dart';
// Part directive for Hive to generate the adapter code
part 'bucket.g.dart';

// Defining a Hive type for Bucket class with a unique typeId
@HiveType(typeId: 3)
class Bucket {
  // Fields for the bucket details with Hive annotations
  @HiveField(0)
  Uint8List? imageFile;

  @HiveField(1)
  DateTime? date;

  @HiveField(2)
  String? selectedTripType;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? location;

  @HiveField(6)
  String? budget;

  // Field to indicate if the bucket item is completed
  bool completed;

  // Constructor to initialize the Bucket class fields with default value for completed
  Bucket({
    required this.date,
    required this.location,
    required this.description,
    required this.budget,
    required this.imageFile,
    this.completed = false, // Default value for completed is false
    required this.selectedTripType,
  });
}
