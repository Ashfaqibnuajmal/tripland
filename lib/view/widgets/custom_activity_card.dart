import 'package:flutter/material.dart';
import 'package:textcodetripland/model/activities_model/activities.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class ActivityCard extends StatelessWidget {
  final Activities activity;
  final bool switchState;
  final ValueChanged<bool> onSwitchChanged;
  final VoidCallback onDeletePressed;

  const ActivityCard({
    Key? key,
    required this.activity,
    required this.switchState,
    required this.onSwitchChanged,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Activity Name
                Text(activity.activity ?? "Unnamed Activity",
                    style: CustomTextStyle.textStyle3),
                const SizedBox(height: 8),
                // Time
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 16, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                        "${activity.fromTime ?? 'No Start Time'} - ${activity.toTime ?? 'No End Time'}",
                        style: CustomTextStyle.textStyle5),
                  ],
                ),
                const SizedBox(height: 8),
                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 8),
                    Text(activity.place ?? "No Location",
                        style: CustomTextStyle.textStyle5),
                  ],
                ),
                const SizedBox(height: 8),
                // Transportation
                Row(
                  children: [
                    const Icon(Icons.directions_car, size: 16),
                    const SizedBox(width: 8),
                    Text(activity.vehicle ?? "No Vehicle",
                        style: CustomTextStyle.textStyle5),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(Icons.more_vert_rounded),
                ),
                const SizedBox(height: 30),
                Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Colors.blue,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  value: switchState,
                  onChanged: onSwitchChanged,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
