import 'package:flutter/material.dart';
import 'package:textcodetripland/view/introscreens/intro_screen_3.dart';
import 'package:textcodetripland/view/settings/login_page.dart';
import '../widgets/custom_intro_screen.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIntroScreen(
      imagePath: "assets/images/introimage2.png",
      nextButtonText: "NEXT",
      showSkipButton: true,
      heading: "Save Memories",
      description:
          "Capture the smiles, breathtaking views, and heartwarming moments. Save your memories and relive the magic of every journey", // Description text
      onNextPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IntroScreen3(),
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
