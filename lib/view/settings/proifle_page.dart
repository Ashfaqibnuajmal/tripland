import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/controllers/user_controllers.dart';
import 'package:textcodetripland/model/user_model/user.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_settings.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/settings/about_us.dart';
import 'package:textcodetripland/view/settings/help_support.dart';
import 'package:textcodetripland/view/settings/login_page.dart';
import 'package:textcodetripland/view/settings/privacy_policy.dart';
import 'package:textcodetripland/view/settings/terms_condition.dart';

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
      appBar: CustomAppBar(
        title: "Profile ",
        ctx: context,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Gap(30),
                  Column(
                    children: [
                      GestureDetector(
                        child: ClipOval(
                          child: Container(
                            width: 120, // Diameter of the circle (2 x radius)
                            height: 120,
                            color: Colors.black12, // Background color
                            child: userdata?.image != null
                                ? Image.file(
                                    File(userdata!
                                        .image!), // Load the file image
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the container
                                  )
                                : Image.asset(
                                    "assets/images/profiePicture.png", // Fallback image
                                    fit: BoxFit
                                        .cover, // Ensure the asset image covers the container
                                  ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                          userdata?.name != null && userdata!.name!.isNotEmpty
                              ? userdata!.name![0].toUpperCase() +
                                  userdata!.name!.substring(1)
                              : "No username", // Fallback if userdata is null or empty
                          style: CustomTextStyle.headings),
                    ],
                  ),
                ],
              ),
              const Divider(thickness: 2),
              const Gap(30),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text("Settings", style: CustomTextStyle.textStyle3),
                ),
              ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SingleChildScrollView(
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
                      const Gap(20),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: Colors.black87,
                              contentPadding: EdgeInsets.zero,
                              content: Container(
                                width: 300,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.report_gmailerrorred_outlined,
                                      size: 30,
                                      color: Colors.redAccent,
                                    ),
                                    const Gap(10),
                                    const Text('Logout?',
                                        style: CustomTextStyle.settings),
                                    const Gap(10),
                                    const Text(
                                      "Are you sure you want to logout?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // Cancel button
                                        Container(
                                          height: 40,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: TextButton(
                                            onPressed: () =>
                                                Navigator.of(ctx).pop(),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        // Logout button
                                        Container(
                                          height: 40,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              _logout();
                                            },
                                            child: const Text(
                                              'Logout',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("LogOut",
                                    style: CustomTextStyle.settings),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
