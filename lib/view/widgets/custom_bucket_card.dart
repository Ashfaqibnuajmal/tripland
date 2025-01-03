import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/model/bucket_model/bucket.dart';
import 'package:textcodetripland/view/bucketlist/bucket_edit.dart';
import 'package:textcodetripland/view/widgets/custom_container.dart';
import 'package:textcodetripland/view/widgets/custom_showdilog.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';

class CustomBucketCard extends StatelessWidget {
  final Bucket bucket;
  final int index;
  final bool switchState;
  final Map<int, bool> favoriteState;
  final Function(int) deleteBucket;
  final Function(int, bool) saveFavoriteStateByKey;
  final Function(int, bool) saveSwitchStateByKey;

  const CustomBucketCard({
    super.key,
    required this.bucket,
    required this.index,
    required this.switchState,
    required this.favoriteState,
    required this.deleteBucket,
    required this.saveFavoriteStateByKey,
    required this.saveSwitchStateByKey,
  });

  @override
  Widget build(BuildContext context) {
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
                      bucket.location?.trim().replaceFirst(bucket.location![0],
                              bucket.location![0].toUpperCase()) ??
                          "NA",
                      style: CustomTextStyle.headings,
                    ),
                    Text(
                      bucket.date == null
                          ? 'N/A'
                          : DateFormat('MMM dd, yyyy').format(bucket.date!),
                      style: CustomTextStyle.textstyle2,
                    ),
                    Text('₹${bucket.budget ?? "NA"}',
                        style: CustomTextStyle.textstyle2),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        showMenu(
                          color: Colors.white,
                          context: context,
                          position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                          items: [
                            const PopupMenuItem(
                              value: "edit",
                              child: Row(
                                children: [
                                  Icon(Icons.edit_calendar_rounded),
                                  SizedBox(width: 8),
                                  Text("Edit"),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline_rounded),
                                  SizedBox(width: 9),
                                  Text("Delete"),
                                ],
                              ),
                            ),
                          ],
                        ).then((value) {
                          if (value == 'edit') {
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => BucketEdit(
                                  budget: bucket.budget,
                                  date: bucket.date,
                                  description: bucket.description,
                                  imageFile: bucket.imageFile,
                                  location: bucket.location,
                                  index: index,
                                  selectedTripType: bucket.selectedTripType,
                                ),
                              ),
                            );
                          } else if (value == 'delete') {
                            showDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder: (ctx) => CustomDeleteDialog(
                                onDelete: () {
                                  deleteBucket(index);
                                },
                                title: 'Delete Bucket?',
                                message:
                                    "Do you really want to remove this trip from your bucket list?",
                              ),
                            );
                          }
                        });
                      },
                      icon: const Icon(Icons.more_vert_rounded),
                    ),
                  ],
                ),
              ],
            ),
            CustomContainer(
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: bucket.imageFile == null
                    ? Image.asset(
                        '', // Default image if no file
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        bucket
                            .imageFile!, // Display the image directly from the Uint8List
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Text(
              (bucket.selectedTripType?.trim().replaceFirst(
                      bucket.selectedTripType![0],
                      bucket.selectedTripType![0].toUpperCase()) ??
                  "NA"),
              style: CustomTextStyle.guides,
            ),
            Text(
              (bucket.description?.trim().replaceFirst(bucket.description![0],
                      bucket.description![0].toUpperCase()) ??
                  "NA"),
              style: CustomTextStyle.textstyle2,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    bool currentState = favoriteState[index] ?? false;
                    bool newState = !currentState;
                    saveFavoriteStateByKey(index, newState);
                  },
                  icon: Icon(
                    favoriteState[index] ?? false
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                  ),
                  color:
                      favoriteState[index] ?? false ? Colors.red : Colors.black,
                ),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: switchState,
                    onChanged: (bool value) {
                      saveSwitchStateByKey(index, value);
                    },
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blue[200],
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
