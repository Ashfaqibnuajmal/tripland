import 'package:hive/hive.dart';
import 'package:textcodetripland/model/checklist_model/checklist.dart';

// Part directive for Hive to generate the adapter code
part 'trip.g.dart';

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

  // Field for the expenses related to the trip
  @HiveField(5)
  String? expance;

  // Field for the image file associated with the trip
  @HiveField(6)
  String? imageFile;

  // Field for the checklist related to the trip
  @HiveField(7)
  List<Checklist>? checklist;

  // Constructor to initialize the Trip class with provided values
  Trip({
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.selectedNumberOfPeople,
    required this.selectedTripType,
    required this.expance,
    required this.imageFile,
    String? numberOfPeople,
    String? tripType,
    this.checklist, // Can be initialized as an empty list if needed
  });
}
