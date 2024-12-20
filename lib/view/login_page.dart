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
                )),
              ),
              const Gap(20),
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  color: Color(0xFFFCC300),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: _pickedImage == null
                    ? Center(
                        child: IconButton(
                          onPressed: _pickImage,
                          icon: const Icon(
                            Icons.person_pin,
                            size: 100,
                            color: Colors.black,
                          ),
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
                child: Column(
                  children: [
                    const Gap(60),
                    Container(
                      height: 55,
                      width: 325,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
                        obscureText: false,
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
                      ),
                    ),
                    const Gap(15),
                    Container(
                      height: 55,
                      width: 325,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black54),
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    Container(
                      height: 55,
                      width: 325,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
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
                      ),
                    ),
                    const Gap(30),
                    Container(
                      height: 58,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFCC300),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                          child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotchBar()));
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.anton(
                              color: Colors.black, fontSize: 20),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
