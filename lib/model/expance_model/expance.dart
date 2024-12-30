import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

// Part directive for Hive to generate the adapter code
part 'expance.g.dart';

// Defining a Hive type for Expance class with a unique typeId
@HiveType(typeId: 1)
class Expance {
  // Field for the date of the expense with Hive annotation
  @HiveField(0)
  final String date;
  // Field for the name of the expense with Hive annotation
  @HiveField(1)
  final String name;
  // Field for the price of the expense with Hive annotation
  @HiveField(2)
  final String price;
  @HiveField(3)
  String id;
  @HiveField(4)
  String tripId;
  // Constructor to initialize the Expance class with the provided date, name, and price
  Expance(
      {required this.date,
      required this.name,
      required this.price,
      required this.tripId})
      : id = const Uuid().v4();
}
