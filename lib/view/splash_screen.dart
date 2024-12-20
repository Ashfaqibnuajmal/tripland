import 'package:flutter/material.dart';
import 'package:textcodetripland/controllers/user_controllers.dart';
import 'package:textcodetripland/view/bottom_navigation.dart';
import 'package:textcodetripland/view/intro_screen_1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextscreen();
  }

  Future<void> _navigateToNextscreen() async {
    bool isLoggedIn = await isUserLoggedIn();
    await Future.delayed(const Duration(seconds: 3));
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NotchBar()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const IntroScreen1()));
    }
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("welcome"),
      ),
    );
  }
}
