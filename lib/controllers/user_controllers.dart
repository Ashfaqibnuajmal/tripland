import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:textcodetripland/model/user_model/user.dart';

// For add user data .
Future<void> addUser(User value) async {
  final userDb = await Hive.openBox<User>('user_db');
  await userDb.put("profile", value);
  log(" user name: ${value.name} password : ${value.password} image : ${value.image} }");
}

// For get the user .
Future<User?> getUser() async {
  final userDb = await Hive.openBox<User>("user_db");
  final data = await userDb.get("profile");
  log('${data?.name ?? 'User is null'}');
  return data;
}

// For logout
Future<void> logoutUser() async {
  final userDb = await Hive.openBox<User>("user_db");
  await userDb.delete('profile');
  log("User logged out.");
}

// for check is user loged in or not
Future<bool> isUserLoggedIn() async {
  final userDB = await Hive.openBox<User>('user_db');
  final user = userDB.get('profile');
  return user != null;
}
