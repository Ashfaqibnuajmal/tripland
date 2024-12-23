import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomIntroScreen extends StatelessWidget {
  final String imagePath;
  final String nextButtonText;
  final bool showSkipButton;
  final String heading;
  final String description;
  final VoidCallback onNextPressed;
  final VoidCallback? onSkipPressed; // Add this line to accept skip callback

  const CustomIntroScreen({
    required this.imagePath,
    required this.nextButtonText,
    required this.showSkipButton,
    required this.heading,
    required this.description,
    required this.onNextPressed,
    this.onSkipPressed, // Allow onSkipPressed to be optional
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Gap(40),
          if (showSkipButton) // Check if skip button should be shown
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: onSkipPressed, // Call the skip callback here
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
            imagePath,
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
                    heading,
                    style: GoogleFonts.anton(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    description,
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
                    onPressed: onNextPressed,
                    child: Text(
                      nextButtonText,
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
