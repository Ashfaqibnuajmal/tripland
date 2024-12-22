import 'package:hive/hive.dart';

// Part directive for Hive to generate the adapter code
part 'journal.g.dart';

// Defining a Hive type for Journal class with a unique typeId
@HiveType(typeId: 4)
class Journal {
  // Field for the image file associated with the journal entry
  @HiveField(0)
  String? imageFile;

  // Field for the date of the journal entry
  @HiveField(1)
  DateTime? date;

  // Field for the time of the journal entry
  @HiveField(2)
  String? time;

  // Field for the location of the journal entry
  @HiveField(3)
  String? location;

  // Field for the selected trip type related to the journal entry
  @HiveField(4)
  String? selectedTripType;

  // Field for the journal's content (description or notes)
  @HiveField(5)
  String? journal;

  // Constructor to initialize the Journal class with provided values
  Journal({
    required this.date,
    required this.imageFile,
    required this.journal,
    required this.location,
    required this.selectedTripType,
    required this.time,
  });
}
