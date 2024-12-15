import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcodetripland/view/bucketlist._add.dart';

class Bucketlist extends StatefulWidget {
  const Bucketlist({super.key});

  @override
  State<Bucketlist> createState() => _BucketlistState();
}

class _BucketlistState extends State<Bucketlist> {
  bool isSwitched = false;

  final List<Map<String, String>> bucketList = [
    {
      'title': 'Himalaya Mountain',
      'date': '21/12/2024',
      'category': 'Adventure',
      'image': 'assets/images/Himalya.png',
      'description':
          'Himalaya is my next dream destination. I will go there before the end of the year.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: bucketList2(),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "BucketList",
        style: GoogleFonts.anton(fontSize: 20),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          showBottomSheetHome(context);
        },
        icon: const Icon(
          Icons.menu_rounded,
          size: 25,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BucketlistAdd()));
          },
          icon: const Icon(
            Icons.add_circle_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget bucketList2() {
    return ListView.builder(
      padding: const EdgeInsets.all(30),
      itemCount: bucketList.length,
      itemBuilder: (context, index) {
        final item = bucketList[index];
        return bucketItem(item);
      },
    );
  }

  Widget bucketItem(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          itemHeader(item['title']!),
          itemImage(item['image']!),
          itemDetails(item),
          itemDescription(item['description']!),
        ],
      ),
    );
  }

  Widget itemHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: -1,
          ),
        ),
        const Gap(60),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ],
    );
  }

  Widget itemImage(String imagePath) {
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget itemDetails(Map<String, String> item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          item['date']!,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          item['category']!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Transform.scale(
          scale: 0.7,
          child: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeColor: Colors.blue,
            activeTrackColor: Colors.blue[200],
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget itemDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        description,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

void showBottomSheetHome(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black87,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Gap(10),
            bottomSheetButton("All"),
            bottomSheetButton("Upcoming"),
            bottomSheetButton("Completed"),
            const Gap(30),
          ],
        ),
      );
    },
  );
}

Widget bottomSheetButton(String text) {
  return Container(
    height: 50,
    width: 300,
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white38,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
