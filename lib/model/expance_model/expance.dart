import 'package:hive/hive.dart';

// Part directive for Hive to generate the adapter code
part 'expance.g.dart';

// Defining a Hive type for Expance class with a unique typeId
@HiveType(typeId: 1)
class Expance {
  // Field for the date of the expense with Hive annotation
  @HiveField(0)
  String? date;

  // Field for the name of the expense with Hive annotation
  @HiveField(1)
  String? name;

  // Field for the price of the expense with Hive annotation
  @HiveField(2)
  String? price;

  // Constructor to initialize the Expance class with the provided date, name, and price
  Expance({required this.date, required this.name, required this.price});
}
