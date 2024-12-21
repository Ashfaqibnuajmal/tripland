import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textcodetripland/model/user.dart';

Future<void> addUser(User value) async {
  log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  final userDb = await Hive.openBox<User>('user_db');
  await userDb.put("profile", value);
  log(" user name: ${value.name} password : ${value.password} image : ${value.image} }");
}

Future<User?> getUser() async {
  final userDb = await Hive.openBox<User>("user_db");
  final data = await userDb.get("profile");
  log('${data?.name ?? 'User is null'}');
  return data;
}

Future<void> logoutUser() async {
  final userDb = await Hive.openBox<User>("user_db");
  await userDb.delete('profile');
  log("User logged out.");
}

Future<bool> isUserLoggedIn() async {
  final userDB = await Hive.openBox<User>('user_db');
  final user = userDB.get('profile');
  return user != null;
}
