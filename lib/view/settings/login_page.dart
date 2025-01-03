import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textcodetripland/controllers/user_controllers.dart';
import 'package:textcodetripland/model/user_model/user.dart';
import 'package:textcodetripland/view/widgets/custom_login.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure = true; // Controls password visibility
  // ignore: prefer_typing_uninitialized_variables
  var _pickedImage; // Store both File (mobile) and String (web) for image
  Uint8List? webImage;
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (kIsWeb) {
        // For web, read the image as bytes and store it as base64
        webImage = await pickedImage.readAsBytes();
        setState(() {
          _pickedImage = base64Encode(webImage!); // Store base64 string for web
        });
      } else {
        // For mobile, store the image as a File
        setState(() {
          _pickedImage = File(pickedImage.path); // Store the file for mobile
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NotchBar()),
        (Route<dynamic> route) => false,
      );
    }
  }

  String? validateUserName(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return "Username is required";
    }
    if (!RegExp(r'^[a-zA-Z0-9]{5,}$').hasMatch(value)) {
      return "Username must be at least 5 characters";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(80),
              Text("Log In to Your Account",
                  textAlign: TextAlign.center, style: CustomTextStyle.headings),
              const Gap(20),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFCC300),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: _pickedImage == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                size: 70,
                                color: Colors.black,
                              ),
                              Text("ADD PHOTO",
                                  style: CustomTextStyle.textStyle4),
                            ],
                          ),
                        )
                      : kIsWeb
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.memory(
                                webImage!,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _pickedImage!,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                            ),
                ),
              ),
              const Gap(30),
              CustomLogin(
                height: 400,
                width: 350,
                color: Colors.black87,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1),
                  ),
                ],
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Gap(50),
                      Container(
                        height: 55,
                        width: 325,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Username",
                            labelStyle: CustomTextStyle.hintText,
                            prefixIcon: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          validator: validateUserName,
                        ),
                      ),
                      const Gap(15),
                      Container(
                        height: 60,
                        width: 325,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Password",
                            labelStyle: CustomTextStyle.hintText,
                            prefixIcon: const Icon(
                              Icons.lock_outlined,
                              size: 30,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          validator: validatePassword,
                        ),
                      ),
                      const Gap(15),
                      Container(
                        height: 60,
                        width: 325,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Confirm Password",
                            labelStyle: CustomTextStyle.hintText,
                            prefixIcon: Icon(
                              Icons.key_outlined,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Gap(30),
                      Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCC300),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_pickedImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Please select an image.')));

                                  return;
                                }
                                final userdata = User(
                                    image: _pickedImage is String
                                        ? _pickedImage
                                        : _pickedImage!.path,
                                    name: _usernameController.text,
                                    password: _passwordController.text);
                                await addUser(userdata);
                                Navigator.push(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NotchBar()));
                              }
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.anton(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
