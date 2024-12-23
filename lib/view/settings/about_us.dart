import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "About us",
          style: GoogleFonts.anton(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 25),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Text(
              "About Us\n\n"
              "Welcome to TravelMate, your ultimate companion for planning, tracking, and cherishing every journey you take. "
              "Whether you're dreaming of future adventures, organizing your current trips, or reliving past experiences, our app is designed to make travel planning and documentation seamless and enjoyable.\n\n"
              "With TravelMate, you can:\n"
              "- Create and manage detailed trip plans, including budgets, guides, and activities.\n"
              "- Keep track of your travel expenses and stay within budget effortlessly.\n"
              "- Use our checklist feature to ensure you never forget essentials for your journey.\n"
              "- Document your adventures through journals with photos, dates, and descriptions.\n"
              "- Plan your bucket list trips and keep your future dreams organized.\n"
              "- Explore filters to sort your trips by categories like upcoming, completed, or top-rated.\n"
              "- Customize your profile and settings, including dark mode for comfortable usage.\n\n"
              "Our mission is to help you stay organized, inspired, and stress-free as you explore the world, one trip at a time. "
              "We aim to simplify travel management so you can focus on creating memories that last a lifetime.\n\n"
              "Start your journey with TravelMate – where every adventure begins with a plan!",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
