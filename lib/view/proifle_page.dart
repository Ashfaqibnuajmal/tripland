import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/controllers/user_controllers.dart';
import 'package:textcodetripland/model/user.dart';
import 'package:textcodetripland/view/about_us.dart';
import 'package:textcodetripland/view/help_support.dart';
import 'package:textcodetripland/view/login_page.dart';
import 'package:textcodetripland/view/privacy_policy.dart';
import 'package:textcodetripland/view/terms_condition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    loaduser();
    super.initState();
  }

  User? userdata;
  void loaduser() async {
    userdata = await getUser();
    setState(() {});
  }

  void _logout() async {
    await logoutUser();
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile", style: GoogleFonts.anton(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, size: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                const Gap(30),
                Column(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.black12,
                        backgroundImage: userdata?.image != null
                            ? FileImage(File(userdata!
                                .image!)) // Convert string to File object
                            : null, // Show a default image if userdata or image is null
                      ),
                    ),
                    const Gap(10),
                    Text(
                      userdata?.name != null && userdata!.name!.isNotEmpty
                          ? userdata!.name![0].toUpperCase() +
                              userdata!.name!.substring(1)
                          : "No username", // Fallback if userdata is null or empty
                      style: GoogleFonts.nobile(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(thickness: 2),
            const Gap(30),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text("Settings",
                    style: GoogleFonts.nobile(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: 320,
              height: 380,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(50)),
              child: Column(
                children: [
                  const Gap(15),
                  SettingsButton(
                    icon: Icons.privacy_tip,
                    label: "Privacy & Policy",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy()),
                      );
                    },
                  ),
                  const Gap(15),
                  SettingsButton(
                    icon: Icons.miscellaneous_services_rounded,
                    label: "Terms of Service",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsCondition()),
                      );
                    },
                  ),
                  const Gap(15),
                  SettingsButton(
                    icon: Icons.help_center_rounded,
                    label: "Help and Support",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpSupport()),
                      );
                    },
                  ),
                  const Gap(15),
                  SettingsButton(
                    icon: Icons.admin_panel_settings_rounded,
                    label: "About Us",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUs()),
                      );
                    },
                  ),
                  const Gap(30),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("logout"),
                                content: const Text(
                                    "ssssssssssssssssssssssssssssssssssssss"),
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        _logout();
                                      },
                                      icon: const Icon(Icons.logout))
                                ],
                              ));
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("LogOut",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const SettingsButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const Spacer(),
            Text(label, style: const TextStyle(color: Colors.black)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
