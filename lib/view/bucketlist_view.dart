import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/view/bucket_edit.dart';
import 'package:textcodetripland/view/bucketlist._add.dart';
import 'package:textcodetripland/view/proifle_page.dart';

// ignore: must_be_immutable
class Bucketlist extends StatefulWidget {
  const Bucketlist({
    super.key,
  });

  @override
  State<Bucketlist> createState() => _BucketlistState();
}

class _BucketlistState extends State<Bucketlist> {
  final Map<int, bool> _switchState = {};
  final Map<int, bool> _favoriteState = {};
  String searchQuery = "";

  Future<void> _loadAllSwitchStates() async {
    final buckets = bucketNotifier.value;
    for (int index = 0; index < buckets.length; index++) {
      String key = 'switchState_$index';
      bool state = await SharedPreferencesHelper.getSwitchStateByKey(key);
      _switchState[index] = state;
    }
    setState(() {});
  }

  Future<void> _loadAllFavoriteStates() async {
    final buckets = bucketNotifier.value;
    for (int index = 0; index < buckets.length; index++) {
      String key = 'favoriteState_$index';
      bool state = await SharedPreferencesHelper.getSwitchStateByKey(key);
      _favoriteState[index] = state;
    }
    setState(() {});
  }

  Future<void> _saveSwitchStateByKey(int index, bool value) async {
    String key = "switchState_$index";
    await SharedPreferencesHelper.saveSwitchStateByKey(key, value);
    setState(() {
      _switchState[index] = value;
    });
  }

  Future<void> _saveFavoriteStateByKey(int index, bool value) async {
    String key = "favoriteState_$index";
    await SharedPreferencesHelper.saveSwitchStateByKey(key, value);
    setState(() {
      _favoriteState[index] = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllBucket();
    _loadAllSwitchStates();
    _loadAllFavoriteStates();
  }

  bool isSwitched = false;

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
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              icon: const Icon(Icons.settings)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BucketlistAdd()));
              },
              icon: const Icon(
                Icons.note_add_rounded,
                size: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 45,
              width: 340,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFCC300), width: 1),
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by location",
                  hintStyle:
                      const TextStyle(color: Colors.black54, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.black54),
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.trim().toLowerCase();
                  });
                },
              ),
            ),
          ),
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: bucketNotifier,
                  builder: (context, bucketlist, child) {
                    final filteredList = bucketlist.where((bucket) {
                      final location = bucket.location?.toLowerCase() ?? "";
                      return location.contains(searchQuery);
                    }).toList();

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
                        bool switchState = _switchState[index] ?? false;
                        return ListTile(
                            title: Card(
                          elevation: 8,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bucket.location?.trim().replaceFirst(
                                                  bucket.location![0],
                                                  bucket.location![0]
                                                      .toUpperCase()) ??
                                              "NA",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: -1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          bucket.date == null
                                              ? 'N/A'
                                              : DateFormat('MMM dd, yyyy')
                                                  .format(bucket.date!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showMenu(
                                                color: Colors.white,
                                                context: context,
                                                position:
                                                    const RelativeRect.fromLTRB(
                                                        100, 100, 0, 0),
                                                items: [
                                                  const PopupMenuItem(
                                                      value: "edit",
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .edit_calendar_rounded,
                                                          ),
                                                          SizedBox(width: 8),
                                                          Text("Edit"),
                                                        ],
                                                      )),
                                                  const PopupMenuItem(
                                                      value: 'delete',
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .delete_outline_rounded),
                                                          SizedBox(width: 9),
                                                          Text("Delete"),
                                                        ],
                                                      ))
                                                ]).then((value) {
                                              if (value == 'edit') {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => BucketEdit(
                                                            date: bucket.date,
                                                            description: bucket
                                                                .description,
                                                            imageFile: bucket
                                                                .imageFile,
                                                            location:
                                                                bucket.location,
                                                            index: index,
                                                            selectedTripType: bucket
                                                                .selectedTripType)));
                                              } else if (value == 'delete') {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    backgroundColor:
                                                        Colors.black87,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    content: Container(
                                                      width: 300,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const Icon(
                                                              Icons
                                                                  .report_gmailerrorred_outlined,
                                                              size: 30,
                                                              color: Colors
                                                                  .redAccent),
                                                          const Gap(10),
                                                          const Text('Delete?',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white)),
                                                          const Gap(10),
                                                          const Text(
                                                            "Are you sure you want to Delete?",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          const Gap(20),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              // Cancel button
                                                              Container(
                                                                height: 40,
                                                                width: 90,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              ctx)
                                                                          .pop(),
                                                                  child:
                                                                      const Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              // Logout button
                                                              Container(
                                                                height: 40,
                                                                width: 90,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    deleteBucket(
                                                                        index);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  // You can link the function here
                                                                  child:
                                                                      const Text(
                                                                    'Delete',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.more_vert_rounded),
                                        ),
                                      ],
                                    )
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
                                  (bucket.selectedTripType?.trim().replaceFirst(
                                          bucket.selectedTripType![0],
                                          bucket.selectedTripType![0]
                                              .toUpperCase()) ??
                                      "NA"),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  (bucket.description?.trim().replaceFirst(
                                          bucket.description![0],
                                          bucket.description![0]
                                              .toUpperCase()) ??
                                      "NA"),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        bool currentState =
                                            _favoriteState[index] ?? false;
                                        bool newState = !currentState;

                                        _saveFavoriteStateByKey(
                                            index, newState);
                                      },
                                      icon: Icon(
                                        _favoriteState[index] ?? false
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                      ),
                                      color: _favoriteState[index] ?? false
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                    Transform.scale(
                                      scale: 0.7,
                                      child: Switch(
                                        value: switchState,
                                        onChanged: (bool value) {
                                          _saveSwitchStateByKey(index, value);
                                        },
                                        activeColor: Colors.blue,
                                        activeTrackColor: Colors.blue[200],
                                        inactiveThumbColor: Colors.grey,
                                        inactiveTrackColor: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                      },
                    );
                  }))
        ]));
  }
}
