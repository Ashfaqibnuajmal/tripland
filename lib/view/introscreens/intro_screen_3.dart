import 'package:flutter/material.dart';
import 'package:textcodetripland/view/settings/login_page.dart';
import '../constants/custom_intro_screen.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIntroScreen(
      imagePath: "assets/images/introimage3.png",
      nextButtonText: "NEXT",
      showSkipButton: true,
      heading: "Global Adventures",
      description:
          "Discover the beauty and diversity our world has to offer. From distant cultures to stunning landscapes, every trip broadens horizons and deepens your sense of wonder", // Description text
      onSkipPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      onNextPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
    );
  }
}
