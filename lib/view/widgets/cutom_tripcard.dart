import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:textcodetripland/model/trip_model/trip.dart';
import 'package:textcodetripland/view/widgets/custom_showdilog.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/homepage/trip_home.dart';

class TripCard extends StatelessWidget {
  final Trip tripData;
  final int index;
  final double initialRating;
  final Future<void> Function(String, double) saveRatingCallback;
  final VoidCallback onDelete;

  const TripCard({
    super.key,
    required this.tripData,
    required this.index,
    required this.initialRating,
    required this.saveRatingCallback,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size
    String tripKey = "rating_${tripData.location}"; // Unique key for each trip

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.black,
              size: 20,
            ),
            Text(
              tripData.location?.isNotEmpty ?? false
                  ? tripData.location![0].toUpperCase() +
                      tripData.location!.substring(1)
                  : 'NA',
              style: CustomTextStyle.location,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TripHome(
                  index: index,
                  location: tripData.location,
                  startDate: tripData.startDate,
                  endDate: tripData.endDate,
                  tripModel: tripData,
                  selectedNumberOfPeople: tripData.selectedNumberOfPeople,
                  selectedTripType: tripData.selectedTripType,
                  expance: tripData.expance,
                  imageFile: tripData.imageFile,
                ),
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (ctx) => CustomDeleteDialog(
                onDelete: onDelete,
                title: 'Delete Itinerary?',
                message: "Do you want to delete this trip permanently?",
              ),
            );
          },
          child: Container(
            height: size.height * 0.35, // Responsive height
            width: size.width * 0.95, // Responsive width
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: tripData.imageFile == null
                  ? Image.asset(
                      'assets/default_image.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Image.memory(
                      tripData.imageFile!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04), // Responsive padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RatingBar.builder(
                initialRating: initialRating,
                minRating: 1,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: size.width * 0.07, // Responsive star size
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) async {
                  await saveRatingCallback(tripKey, newRating);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.05), // Responsive spacing
      ],
    );
  }
}
