import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Wayanad Churam", style: GoogleFonts.anton(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 25),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Date:21/07/2022",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Date:21/07/2022",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Image.asset(
              "assets/images/ashfaq.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "This picture was taken during my last trip with friends—a spontaneous adventure! We originally planned to visit Ooty, but due to weather conditions, we decided to head to Wayanad instead. When we reached the top of Wayanad Churam, we were greeted by the best climate—cool temperatures with a light drizzle. It was truly refreshing! Many families were there, capturing their own memories, making the experience even more special for us.",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
