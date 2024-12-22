import 'package:hive/hive.dart';

// Part directive for Hive to generate the adapter code
part 'user.g.dart';

// Defining a Hive type for User class with a unique typeId
@HiveType(typeId: 5)
class User {
  // Field for the user's profile image
  @HiveField(0)
  String? image;

  // Field for the user's name
  @HiveField(1)
  String? name;

  // Field for the user's password
  @HiveField(2)
  String? password;

  // Constructor to initialize the User class with provided values
  User({
    required this.image,
    required this.name,
    required this.password,
  });
}
