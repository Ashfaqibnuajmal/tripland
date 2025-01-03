// custom_navigation_button.dart
import 'package:flutter/material.dart';

class CustomAction extends StatelessWidget {
  final Widget destinationPage;

  const CustomAction({
    super.key,
    required this.destinationPage, // The destination page is passed to this widget
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                destinationPage, // Navigate to the passed destination page
          ),
        );
      },
      icon: const Icon(
        Icons.note_add_rounded,
        size: 25,
        color: Colors.black,
      ),
    );
  }
}
