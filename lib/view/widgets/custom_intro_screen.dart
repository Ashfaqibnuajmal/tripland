import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class CustomIntroScreen extends StatelessWidget {
  final String imagePath;
  final String nextButtonText;
  final bool showSkipButton;
  final String heading;
  final String description;
  final VoidCallback onNextPressed;
  final VoidCallback? onSkipPressed;

  const CustomIntroScreen({
    super.key,
    required this.imagePath,
    required this.nextButtonText,
    required this.showSkipButton,
    required this.heading,
    required this.description,
    required this.onNextPressed,
    this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Gap(40),
          if (showSkipButton)
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: onSkipPressed,
                label: const Text("SKIP", style: CustomTextStyle.textStyle4),
              ),
            ),
          Image.asset(
            imagePath,
            height: size.height * 0.55,
            width: size.width * 0.9,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Container(
              height: size.height * 0.1,
              padding: EdgeInsets.all(size.width * 0.02),
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
                  Text(heading, style: CustomTextStyle.introHeadings),
                  const Gap(16),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.introDescriptions,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.01,
                      ),
                    ),
                    onPressed: onNextPressed,
                    child: Text(nextButtonText, style: CustomTextStyle.button),
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
