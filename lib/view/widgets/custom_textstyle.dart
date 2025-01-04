import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static const TextStyle intro = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle introHeadings = GoogleFonts.roboto(textStyle: intro);

  static const TextStyle introDescription = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );

  static final TextStyle introDescriptions =
      GoogleFonts.roboto(textStyle: introDescription);

  static const TextStyle button = TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: -1,
    color: Colors.black,
    fontSize: 14,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 20,
    letterSpacing: -1,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle headings = GoogleFonts.roboto(textStyle: heading);

  static const TextStyle search = TextStyle(
    color: Colors.black54,
    fontSize: 14,
  );

  static const TextStyle location =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -1);

  static const TextStyle empty = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle guides = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Colors.black87,
  );
  static const TextStyle hintText = TextStyle(
    fontSize: 12,
    color: Colors.black38,
  );

  static const TextStyle expense = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle settings = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.white,
  );

  static const TextStyle settingsText = TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle category = TextStyle(
    color: yellow,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle textstyle1 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle textstyle2 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textStyle3 =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black);
  static const TextStyle textStyle4 =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black);
  static const TextStyle textStyle5 =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black);
  static const TextStyle textStyle6 =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black);
  static const TextStyle textStyle7 =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle textstyle8 =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600);

  // Colors
  static const Color yellow = Color(0xFFFCC300);
}
