import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Help & Support",
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
Help and Support

At TravelMate, we’re here to make your travel experience smooth. If you encounter issues or have questions, we’re ready to help!

1. FAQ
- **How do I create a new trip?** Go to "Add Trip" on the home page, fill in details, and save.
- **How do I delete a trip?** Open the trip, tap Delete, and confirm.
- **Switch views?** Use the toggle button on the home page.

2. Contact Us
- **Email:** support@travelmate.com
- **Phone:** +1-234-567-8900 (Mon-Fri, 9 AM - 5 PM)
- **Live Chat:** On our website.

3. Technical Support
- Restart the app, update to the latest version, or clear cache.
- Email us with issue details, screenshots, and your app version if problems persist.

4. Feedback
We’d love to hear from you! Use the app’s Feedback option or email feedback@travelmate.com.

5. Resources
Visit our website for guides and tutorials or check out our YouTube channel.

We’re committed to supporting you. Happy travels!
            ''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
