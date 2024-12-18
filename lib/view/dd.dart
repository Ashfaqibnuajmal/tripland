import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/model/bucket.dart';

// Enum for filter options
enum FilterType { all, completed, incomplete }

class Bucketlist extends StatefulWidget {
  const Bucketlist({super.key});

  @override
  State<Bucketlist> createState() => _BucketlistState();
}

class _BucketlistState extends State<Bucketlist> {
  @override
  void initState() {
    super.initState();
    getAllBucket();
  }

  FilterType currentFilter = FilterType.all; // Default filter is 'All'

  List<Bucket> getFilteredBuckets(List<Bucket> buckets) {
    switch (currentFilter) {
      case FilterType.completed:
        return buckets.where((bucket) => bucket.completed).toList();
      case FilterType.incomplete:
        return buckets.where((bucket) => !bucket.completed).toList();
      case FilterType.all:
      default:
        return buckets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "BucketList",
          style: GoogleFonts.anton(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          // Filter buttons in the app bar
          IconButton(
            onPressed: () {
              setState(() {
                currentFilter = FilterType.all;
              });
            },
            icon: const Icon(Icons.all_inclusive),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                currentFilter = FilterType.completed;
              });
            },
            icon: const Icon(Icons.check_box),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                currentFilter = FilterType.incomplete;
              });
            },
            icon: const Icon(Icons.check_box_outline_blank),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: bucketNotifier,
        builder: (context, bucketlist, child) {
          // Get the filtered bucket list based on the selected filter
          List<Bucket> filteredList = getFilteredBuckets(bucketlist);

          if (filteredList.isEmpty) {
            return const Center(
              child: Text(
                "No BucketList Found!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final bucket = filteredList[index];
              return _buildBucketCard(bucket, index);
            },
          );
        },
      ),
    );
  }

  // The method to build a single bucket card (updated for completed field)
  Widget _buildBucketCard(Bucket bucket, int index) {
    return Card(
      elevation: 8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bucket.location ?? "N/A",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(bucket.date == null
                        ? 'N/A'
                        : DateFormat('MMM dd, yyyy').format(bucket.date!)),
                  ],
                ),
                Icon(
                  bucket.completed
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                ),
              ],
            ),
            Container(
              height: 250,
              width: 300,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(bucket.imageFile ?? "NA"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              bucket.selectedTripType ?? "NA",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              bucket.description ?? "NA",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    bool currentState = bucket.completed;
                    bool newState = !currentState;

                    setState(() {
                      bucket.completed = newState;
                      // You should save this state to your database or any storage here
                    });
                  },
                  icon: Icon(
                    bucket.completed
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                  ),
                  color: bucket.completed ? Colors.red : Colors.black,
                ),
                Switch(
                  value: bucket.completed,
                  onChanged: (bool value) {
                    setState(() {
                      bucket.completed = value;
                      // Save the state to your database here as well
                    });
                  },
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.blue[200],
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
