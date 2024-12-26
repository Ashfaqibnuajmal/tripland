import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
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

1. Frequently Asked Questions (FAQ)

How do I create a new trip?
Navigate to the "Add Trip" button on the home page, enter the required details, and save.

How do I delete a trip?
Open the trip you want to delete, tap the "Delete" button, and confirm the action.
How do I switch between list and grid views?
Use the toggle button on the home page to switch between views.


2. Contact Us

If you need further assistance, reach out to us through the following channels:

Email: support@travelmate.com
Phone: +1-234-567-8900 (Available Mon-Fri, 9:00 AM - 5:00 PM)
Live Chat: Accessible through our website or app.
3. Technical Support
For technical issues, try the following steps:


Restart the app.
Update to the latest version from your app store.
Clear the app cache.
If the issue persists, email us with the following details:

A description of the problem.
Screenshots (if applicable).
Your device and app version.


4. Feedback

We value your feedback to improve TravelMate! Share your suggestions, ideas, or concerns using the Feedback option in the app or email us at feedback@travelmate.com.


5. Additional Resources

Explore our guides, tutorials, and tips to get the most out of TravelMate:

Visit our website: [Insert Website URL]
Check out our YouTube channel for video walkthroughs and updates.
            ''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
