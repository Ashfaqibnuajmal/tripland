import 'package:hive/hive.dart';
part 'trip.g.dart';

@HiveType(typeId: 0)
class Trip {
  @HiveField(0)
  String? location;
  @HiveField(1)
  DateTime? startDate;
  @HiveField(2)
  DateTime? endDate;
  @HiveField(3)
  String? selectedNumberOfPeople;
  @HiveField(4)
  String? selectedTripType;
  @HiveField(5)
  String? expance;
  @HiveField(6)
  String? imageFile;

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
  });
}
