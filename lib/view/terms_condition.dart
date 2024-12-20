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

Welcome to TravelMate! By using our app, you agree to the following terms:

1. **Acceptance of Terms**
By accessing TravelMate, you accept these Terms. Discontinue use if you disagree.

2. **Use of the App**
- Purpose: For personal travel planning and journaling.
- User Responsibilities:
  - Provide accurate data when using the app.
  - Secure your account and device.
  - Avoid illegal or harmful activities.

3. **Intellectual Property**
All app content is owned by TravelMate or its licensors. Do not copy, modify, or distribute without permission.

4. **Privacy**
Usage is subject to our Privacy Policy, outlining how we manage your data.

5. **Account Termination**
We may suspend accounts for:
- Violating Terms.
- Misusing the app.

6. **Limitation of Liability**
- TravelMate is provided "as is."
- We are not liable for loss or damage during usage.

7. **Updates and Modifications**
Terms and app features may change. Check periodically for updates.

8. **Third-Party Services**
We are not responsible for third-party content linked to or integrated with the app.

9. **Governing Law**
These Terms follow the laws of [Insert Country/Region]. Disputes will be settled in its courts.

10. **Contact Us**
- Email: support@travelmate.com
- Address: [Insert Address]

Thank you for using TravelMate!
            ''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
