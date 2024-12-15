import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textcodetripland/view/about_us.dart';
import 'package:textcodetripland/view/help_support.dart';
import 'package:textcodetripland/view/logout_message.dart';
import 'package:textcodetripland/view/privacy_policy.dart';
import 'package:textcodetripland/view/terms_condition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  bool _isSwitched = false;
  Future<void> _picImage() async {
    final picker = ImagePicker();
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        _image = File(PickedFile.path);
      });
    }
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
        actions: [
          IconButton(
            onPressed: () => showLogoutDialog(context, () {}),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
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
                      onTap: _picImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.black12,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(
                                Icons.photo_camera_back_rounded,
                                size: 40,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const Gap(10),
                    Text("ASHFAQ KV",
                        style: GoogleFonts.nobile(
                            fontWeight: FontWeight.bold, fontSize: 18)),
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
                                builder: (context) => const PrivacyPolicy()));
                      }),
                  const Gap(15),
                  SettingsButton(
                      icon: Icons.miscellaneous_services_rounded,
                      label: "Terms of Service",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TermsCondition()));
                      }),
                  const Gap(15),
                  SettingsButton(
                      icon: Icons.help_center_rounded,
                      label: "Help and Support",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HelpSupport()));
                      }),
                  const Gap(15),
                  SettingsButton(
                      icon: Icons.admin_panel_settings_rounded,
                      label: "About Us",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutUs()));
                      }),
                  const Gap(15),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Dark mode",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Switch(
                          value: _isSwitched,
                          onChanged: (value) =>
                              setState(() => _isSwitched = value),
                          activeColor: Colors.black,
                          activeTrackColor: Colors.white60,
                          inactiveThumbColor: Colors.black,
                          inactiveTrackColor: Colors.white,
                        ),
                      ],
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
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed})
      : super(key: key);

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
