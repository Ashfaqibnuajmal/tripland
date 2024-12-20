import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textcodetripland/view/bottom_navigation.dart';

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
  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  void _validateAndSubmit() {
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotchBar()));
    }
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
              Text(
                "Log In to Your Account",
                textAlign: TextAlign.center,
                style: GoogleFonts.anton(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
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
                              Text(
                                "ADD PHOTO",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
              Container(
                height: 400,
                width: 350,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
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
                            labelStyle: TextStyle(color: Colors.black54),
                            prefixIcon: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
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
                            labelStyle: const TextStyle(color: Colors.black54),
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
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
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
                            labelStyle: TextStyle(color: Colors.black54),
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
                            onPressed: _validateAndSubmit,
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
