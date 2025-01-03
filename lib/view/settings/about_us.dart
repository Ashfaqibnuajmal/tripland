import 'package:flutter/material.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'About us',
        ctx: context,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Text('''

Welcome to Trippy – your ultimate travel companion, thoughtfully crafted to make every aspect of your journeys effortless and enjoyable.


 Whether you're dreaming of adventures yet to come, organizing your current travels, or cherishing memories of trips past, 
 Trippy is here to support you every step of the way.

What Trippy Offers:
With Trippy, you can:

Plan with Precision: Create and manage detailed itineraries, including budgets, activities, and travel guides.

Track Expenses: Monitor your travel spending and stick to your budget with ease.

Stay Organized: Use our checklist feature to ensure you pack everything you need.

Capture Memories: Document your adventures through personalized journals with photos, dates, and descriptions.

Dream Big: Plan your bucket list trips and keep your travel goals organized.

Effortless Navigation: Explore and sort your trips by categories such as upcoming, completed, or top-rated.

Personalized Experience: Customize your profile, adjust settings, and enjoy dark mode for a comfortable and user-friendly experience.
Our Mission

At Trippy, our mission is simple:
We aim to make travel planning and management stress-free, inspiring you to explore the world and focus on what truly matters—creating lasting memories.''',
                textAlign: TextAlign.justify,
                style: CustomTextStyle.settingsText),
          ),
        ),
      ),
    );
  }
}
