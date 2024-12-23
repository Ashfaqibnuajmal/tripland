import 'package:flutter/material.dart';
import 'package:textcodetripland/view/introscreens/intro_screen_2.dart';
import 'package:textcodetripland/view/settings/login_page.dart';
import '../constants/custom_intro_screen.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIntroScreen(
      imagePath: "assets/images/intro_img1.png", // I
      nextButtonText: "NEXT",
      showSkipButton: true,
      heading: "Let's Started",
      description:
          "Let's get started on a journey where every mile brings a new story and every destination deepens the bond. Together, let's make memories that last a lifetime.", // Description text
      onNextPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IntroScreen2(),
          ),
        );
      },
      onSkipPressed: () {
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
