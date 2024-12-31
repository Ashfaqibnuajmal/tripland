import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'trip.g.dart';

// Part directive for Hive to generate the adapter code
// Defining a Hive type for Trip class with a unique typeId
@HiveType(typeId: 0)
class Trip {
  // Field for the location of the trip
  @HiveField(0)
  String? location;

  // Field for the start date of the trip
  @HiveField(1)
  DateTime? startDate;

  // Field for the end date of the trip
  @HiveField(2)
  DateTime? endDate;

  // Field for the selected number of people for the trip
  @HiveField(3)
  String? selectedNumberOfPeople;

  // Field for the selected type of trip (e.g., adventure, leisure)
  @HiveField(4)
  String? selectedTripType;

  // Field for the expenses related to the trip (changed to double)
  @HiveField(5)
  String? expance;

  // Field for the image file associated with the trip
  @HiveField(6)
  Uint8List? imageFile;

  // Field for the unique identifier of the trip
  @HiveField(7)
  final String id;

  // Constructor to initialize the Trip class with provided values
  Trip({
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.selectedNumberOfPeople,
    required this.selectedTripType,
    required this.expance, // expance now expects a double
    required this.imageFile,
    String? id, // Optional id parameter
  }) : id = id ??
            const Uuid().v4(); // If id is not provided, generate a new one
}
