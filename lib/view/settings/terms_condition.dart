import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Terms & Condition",
          style: GoogleFonts.anton(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
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
Terms and Conditions
Effective Date: [Insert Date]

Welcome to TravelMate! By accessing or using our app, you agree to abide by these Terms and Conditions. If you do not agree, please discontinue use immediately.


1. Acceptance of Terms

By using TravelMate, you confirm your acceptance of these Terms. This agreement applies to all users of the app.


2. Use of the App

Purpose: TravelMate is designed for personal travel planning and journaling.
User Responsibilities:
Provide accurate and truthful information when using the app.
Ensure the security of your account, including login credentials.
Use the app in compliance with applicable laws and avoid harmful activities.


3. Intellectual Property

All content within the app, including designs, logos, and features, is the property of TravelMate or its licensors. You may not copy, distribute, or modify app content without prior written permission.


4. Privacy

Your use of TravelMate is governed by our Privacy Policy. The Privacy Policy explains how your data is collected, stored, and used.


5. Account Termination

We reserve the right to suspend or terminate your account if:
You violate these Terms.
Your actions misuse the app or harm other users.


6. Limitation of Liability

TravelMate is provided on an "as is" basis without warranties of any kind.
We are not responsible for any losses or damages incurred during the use of the app.


7. Updates and Modifications

We may update these Terms or modify app features from time to time. Please review the Terms periodically for changes. Continued use of the app signifies your acceptance of updates.

8. Third-Party Services

TravelMate may include third-party content or services. We are not responsible for the accuracy, legality, or functionality of these external tools or content.

9. Governing Law

These Terms are governed by the laws of [Insert Country/Region]. Any disputes will be resolved in the courts of the same jurisdiction. 

10. Contact Us
If you have any questions about these Terms, please contact us:

Email: support@travelmate.com
Address: [Insert Address]
            ''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
