import 'package:flutter/material.dart';
import 'package:textcodetripland/view/constants/custom_back_arrow.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Help & Support",
          style: CustomTextStyle.settings,
        ),
        centerTitle: true,
        elevation: 4,
        leading: CustomBackButton(
          ctx: context,
          color: Colors.white,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text('''
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

Email: ashfaqkv2107@gmail.com
Phone: 9846100721(Available Mon-Fri, 9:00 AM - 5:00 PM)
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

We value your feedback to improve Trippy! Share your suggestions, ideas, or concerns using the Feedback option in the app or email us at ashfaqkv2107@gmail.com.


5. Additional Resources

Explore our guides, tutorials, and tips to get the most out of TravelMate:

Check out our YouTube channel for video walkthroughs and updates.
            ''',
              textAlign: TextAlign.justify,
              style: CustomTextStyle.settingsText),
        ),
      ),
    );
  }
}
