import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("About us",
            style: GoogleFonts.anton(color: Colors.white, fontSize: 20)),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded,
              color: Colors.white, size: 25),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
About Us

Welcome to TravelMate, your ultimate companion for planning, tracking, and cherishing every journey you take. Whether you're dreaming of future adventures, organizing your current trips, or reliving past experiences, our app is designed to make travel planning and documentation seamless and enjoyable.

With TravelMate, you can:
- Create and manage detailed trip plans, including budgets, guides, and activities.
- Keep track of your travel expenses and stay within budget effortlessly.
- Use our checklist feature to ensure you never forget essentials for your journey.
- Document your adventures through journals with photos, dates, and descriptions.
- Plan your bucket list trips and keep your future dreams organized.
- Explore filters to sort your trips by categories like upcoming, completed, or top-rated.
- Customize your profile and settings, including dark mode for comfortable usage.

Our mission is to help you stay organized, inspired, and stress-free as you explore the world, one trip at a time. We aim to simplify travel management so you can focus on creating memories that last a lifetime.

Start your journey with TravelMate – where every adventure begins with a plan!
            ''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
