import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/view/introscreens/intro_screen_3.dart';
import 'package:textcodetripland/view/settings/login_page.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Gap(40),
          Align(
            alignment: Alignment.topRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              label: Text(
                "SKIP",
                style: GoogleFonts.nobile(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            "assets/images/introimage2.png",
            height: 450,
            width: 450,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(3, 3),
                  ),
                ],
                color: Colors.black87,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Save Memories",
                    style: GoogleFonts.anton(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    "Capture the smiles, breathtaking views, and heartwarming moments. Save your memories and relive the magic of every journey",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nobile(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Gap(16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCC300),
                      elevation: 3,
                      shadowColor: Colors.yellowAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IntroScreen3(),
                        ),
                      );
                    },
                    child: Text(
                      "NEXT",
                      style: GoogleFonts.anton(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14,
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
    );
  }
}
