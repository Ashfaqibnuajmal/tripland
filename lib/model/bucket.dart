import 'package:hive/hive.dart';
part 'bucket.g.dart';

@HiveType(typeId: 3)
class Bucket {
  @HiveField(0)
  String? imageFile;
  @HiveField(1)
  DateTime? date;
  @HiveField(2)
  String? selectedTripType;
  @HiveField(4)
  String? description;
  @HiveField(5)
  String? location;
  bool completed;
  Bucket(
      {required this.date,
      required this.location,
      required this.description,
      required this.imageFile,
      this.completed = false,
      required this.selectedTripType});
}
