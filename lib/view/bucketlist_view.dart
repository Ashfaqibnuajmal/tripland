import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/model/bucket.dart';
import 'package:textcodetripland/view/bucket_edit.dart';
import 'package:textcodetripland/view/bucketlist._add.dart';

enum FilterType { all, completed, incomplete }

// ignore: must_be_immutable
class Bucketlist extends StatefulWidget {
  Bucketlist({
    super.key,
  });

  @override
  State<Bucketlist> createState() => _BucketlistState();
}

class _BucketlistState extends State<Bucketlist> {
  final TextEditingController _searchController = TextEditingController();

  final Map<int, bool> _favoriteState = {};
  Map<int, bool> _switchState = {};

  FilterType currentFilter = FilterType.all;
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

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        height: 45,
        width: 340,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFCC300), width: 1),
          color: Colors.white12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.black54),
            suffixIcon: IconButton(
              onPressed: () {
                _searchController.clear();
              },
              icon: const Icon(
                Icons.cancel_rounded,
                size: 20,
                color: Colors.black,
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10, top: 10),
          ),
        ),
      ),
    );
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
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
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
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const Gap(10),
                      Container(
                        height: 50,
                        width: 300,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = FilterType.all;
                              Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            "All",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = FilterType.completed;
                              Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            "Completed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = FilterType.incomplete;
                              Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            "Incompleted",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Gap(30),
                    ],
                  ),
                );
              },
            );
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
      body: ValueListenableBuilder(
          valueListenable: bucketNotifier,
          builder: (context, bucketlist, child) {
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
                bool switchState = _switchState[index] ?? bucket.completed;

                return ListTile(
                  title: Card(
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
                                          position: const RelativeRect.fromLTRB(
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
                                                  builder: (context) =>
                                                      BucketEdit(
                                                        index: 0,
                                                      )));
                                        } else if (value == 'delete') {
                                          showDialog(
                                            // ignore: use_build_context_synchronously
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.black54,
                                                title: const Center(
                                                  child: Text(
                                                      "Delete Confirmation",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white)),
                                                ),
                                                content: const Text(
                                                  '''   Are you sure you want to delete
                      this bucket?''',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop();
                                                          await deleteBucket(
                                                              index);
                                                        },
                                                        child: const Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.more_vert_rounded),
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
                                    bucket.description![0].toUpperCase()) ??
                                "NA"),
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
                                  bool currentState =
                                      _favoriteState[index] ?? false;
                                  bool newState = !currentState;

                                  _saveFavoriteStateByKey(index, newState);
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
                  ),
                );
              },
            );
          }),
    );
  }
}
