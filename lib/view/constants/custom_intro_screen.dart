// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:textcodetripland/view/constants/custom_textstyle.dart';

// class CustomIntroScreen extends StatelessWidget {
//   final String imagePath;
//   final String nextButtonText;
//   final bool showSkipButton;
//   final String heading;
//   final String description;
//   final VoidCallback onNextPressed;
//   final VoidCallback? onSkipPressed; // Add this line to accept skip callback

//   const CustomIntroScreen({
//     super.key,
//     required this.imagePath,
//     required this.nextButtonText,
//     required this.showSkipButton,
//     required this.heading,
//     required this.description,
//     required this.onNextPressed,
//     this.onSkipPressed, // Allow onSkipPressed to be optional
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           const Gap(40),
//           if (showSkipButton) // Check if skip button should be shown
//             Align(
//               alignment: Alignment.topRight,
//               child: TextButton.icon(
//                 onPressed: onSkipPressed, // Call the skip callback here
//                 label: const Text("SKIP", style: CustomTextStyle.textStyle4),
//               ),
//             ),
//           Image.asset(
//             imagePath,
//             height: 450,
//             width: 450,
//             fit: BoxFit.contain,
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 10,
//                     offset: const Offset(3, 3),
//                   ),
//                 ],
//                 color: Colors.black87,
//                 borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(100),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(heading, style: CustomTextStyle.introHeadings),
//                   const Gap(16),
//                   Text(description,
//                       textAlign: TextAlign.center,
//                       style: CustomTextStyle.introDescriptions),
//                   const Gap(16),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFCC300),
//                         elevation: 3,
//                         shadowColor: Colors.yellowAccent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 32,
//                           vertical: 8,
//                         ),
//                       ),
//                       onPressed: onNextPressed,
//                       child:
//                           Text(nextButtonText, style: CustomTextStyle.button)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:textcodetripland/view/constants/custom_textstyle.dart';

class CustomIntroScreen extends StatelessWidget {
  final String imagePath;
  final String nextButtonText;
  final bool showSkipButton;
  final String heading;
  final String description;
  final VoidCallback onNextPressed;
  final VoidCallback? onSkipPressed; // Add this line to accept skip callback

  const CustomIntroScreen({
    super.key,
    required this.imagePath,
    required this.nextButtonText,
    required this.showSkipButton,
    required this.heading,
    required this.description,
    required this.onNextPressed,
    this.onSkipPressed, // Allow onSkipPressed to be optional
  });

  @override
  Widget build(BuildContext context) {
    // Getting the screen size for responsive layout
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjusting image and button sizes based on screen width
    double imageHeight = screenHeight * 0.4; // 40% of screen height
    double imageWidth = screenWidth * 0.8; // 80% of screen width
    double padding = screenWidth * 0.05; // 5% padding of screen width

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Ensures everything is centered
        children: [
          const Gap(40),
          if (showSkipButton) // Check if skip button should be shown
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: onSkipPressed, // Call the skip callback here
                label: const Text("SKIP", style: CustomTextStyle.textStyle4),
              ),
            ),
          // Responsive Image
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth * 0.1), // Add horizontal padding to center
            child: Image.asset(
              imagePath,
              height: imageHeight,
              width: imageWidth,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(3, 3),
                  ),
                ],
                color: Colors.black87,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Ensures center alignment
                children: [
                  // Responsive Heading
                  Text(
                    heading,
                    style: CustomTextStyle.introHeadings.copyWith(
                      fontSize: screenWidth *
                          0.06, // Adjust font size based on screen width
                    ),
                  ),
                  const Gap(16),
                  // Responsive Description
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.introDescriptions.copyWith(
                      fontSize: screenWidth *
                          0.04, // Adjust font size based on screen width
                    ),
                  ),
                  const Gap(16),
                  // Responsive Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCC300),
                      elevation: 3,
                      shadowColor: Colors.yellowAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            screenWidth * 0.1, // Adjust horizontal padding
                        vertical:
                            screenHeight * 0.02, // Adjust vertical padding
                      ),
                    ),
                    onPressed: onNextPressed,
                    child: Text(
                      nextButtonText,
                      style: CustomTextStyle.button.copyWith(
                        fontSize: screenWidth *
                            0.05, // Adjust font size based on screen width
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
