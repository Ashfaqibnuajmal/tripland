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

Welcome to TravelMate! Your privacy is important to us. Here's how we handle your data:

1. **Information We Collect**
- Personal Info: Name, email, profile picture.
- Trip Details: Names, locations, budgets, etc.
- Journals: Photos and descriptions.
- Usage Data: App navigation and preferences.

2. **How We Use Your Data**
- Enhance app features and personalize experiences.
- Store and display trips and journals.
- Provide support and send updates.

3. **Data Sharing & Security**
- **Sharing:** No third-party sharing unless required by law.
- **Security:** Your data is protected from unauthorized access.

4. **Your Rights**
- Access, update, or delete your data.
- Opt out of notifications or withdraw consent.

5. **Third-Party Tools**
Integrated tools (e.g., analytics) are governed by their privacy policies.

6. **Policy Updates**
Changes will be posted here. Please review periodically.

7. **Contact Us**
- Email: support@travelmate.com
- Address: [Insert Address]

Thank you for trusting TravelMate!
            ''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
