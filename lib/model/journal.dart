import 'package:hive/hive.dart';
part 'journal.g.dart';

@HiveType(typeId: 4)
class Journal {
  @HiveField(0)
  String? imageFile;
  @HiveField(1)
  DateTime? date;
  @HiveField(2)
  String? time;
  @HiveField(3)
  String? location;
  @HiveField(4)
  String? selectedTripType;
  @HiveField(5)
  String? journal;
  Journal(
      {required this.date,
      required this.imageFile,
      required this.journal,
      required this.location,
      required this.selectedTripType,
      required this.time});
}
