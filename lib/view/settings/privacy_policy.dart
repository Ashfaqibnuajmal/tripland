import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Privacy & Policy",
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
Privacy Policy
Effective Date: [Insert Date]

Welcome to TravelMate! We value your trust and are committed to safeguarding your privacy. Here’s how we handle your information:


1. Information We Collect

Personal Information: Name, email, and profile picture for account creation and authentication.
Trip Details: Information like trip names, locations, dates, budgets, guides, and photos.
Journals: Photos, dates, locations, and descriptions added to your journal entries.
Usage Data: App navigation, preferences, and filters to improve your experience.


2. How We Use Your Data

To personalize and enhance app features like trip and journal management.
To store and display your trips, bucket lists, and journal entries.
To send updates, respond to inquiries, and provide support.


3. Data Sharing & Security

Sharing: We don’t share your information with third parties unless legally required.
Security: We use encryption and secure servers to protect your data from unauthorized access.


4. Your Rights

Access, update, or delete your personal data through the app’s settings.
Opt out of notifications or withdraw consent for data collection anytime.


5. Third-Party Services

Integrated tools like analytics are governed by their own privacy policies. We recommend reviewing them to understand how they handle your data.

6. Policy Updates

We may update this policy periodically. Any changes will be posted here, so please check back regularly.

7. Contact Us

Have questions or concerns? Reach out to us:

Email: support@travelmate.com

            ''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
