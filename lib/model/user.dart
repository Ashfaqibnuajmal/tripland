import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 5)
class User {
  @HiveField(0)
  String? image;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? password;

  User({
    required this.image,
    required this.name,
    required this.password,
  });
}
