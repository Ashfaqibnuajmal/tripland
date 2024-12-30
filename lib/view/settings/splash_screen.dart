import 'package:flutter/material.dart';
import 'package:textcodetripland/controllers/user_controllers.dart';
import 'package:textcodetripland/view/homepage/bottom_navigation.dart';
import 'package:textcodetripland/view/introscreens/intro_screen_1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Duration for scaling animation
    );

    // Define the scale animation (starting from small to big)
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _controller.forward();

    // Call the navigation method after animation delay
    _navigateToNextscreen();
  }

  Future<void> _navigateToNextscreen() async {
    bool isLoggedIn = await isUserLoggedIn();
    await Future.delayed(
        const Duration(seconds: 2)); // Wait for animation to complete

    if (isLoggedIn) {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => NotchBar()),
      );
    } else {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen1()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to avoid ticker issues
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value, // Apply the scaling animation
              child: Image.asset(
                'assets/images/logo.png', // Replace with your image path
                width: 400, // Adjust size as needed
                height: 400,
              ),
            );
          },
        ),
      ),
    );
  }
}
