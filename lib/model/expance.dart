import 'package:hive/hive.dart';
part 'expance.g.dart';

@HiveType(typeId: 1)
class Expance {
  @HiveField(0)
  String? date;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? price;
  Expance({required this.date, required this.name, required this.price});
}
