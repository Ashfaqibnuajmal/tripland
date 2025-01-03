import 'package:flutter/material.dart';
import 'package:textcodetripland/controllers/bucket_controllers.dart';
import 'package:textcodetripland/view/bucketlist/bucketlist._add.dart';
import 'package:textcodetripland/view/widgets/custom_action.dart';
import 'package:textcodetripland/view/widgets/custom_appbar.dart';
import 'package:textcodetripland/view/widgets/custom_bucket_card.dart';
import 'package:textcodetripland/view/widgets/custom_textstyle.dart';
import 'package:textcodetripland/view/settings/proifle_page.dart';

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
        appBar: CustomAppBar(
          title: "BucketList",
          ctx: context,
          actions: const [
            CustomAction(destinationPage: BucketlistAdd()),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
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
                  hintStyle: CustomTextStyle.search,
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
                // Filter the bucketlist based on searchQuery
                final filteredList = bucketlist.where((bucket) {
                  final location = bucket.location?.toLowerCase() ?? "";
                  return location.contains(searchQuery);
                }).toList();

                // Reverse the filtered list
                final reversedFilteredList = filteredList.toSet().toList();

                if (reversedFilteredList.isEmpty) {
                  return const Center(
                    child: Text("No BucketList Found!",
                        style: CustomTextStyle.empty),
                  );
                }

                return ListView.builder(
                  itemCount: reversedFilteredList.length,
                  itemBuilder: (context, index) {
                    final bucket = reversedFilteredList[index];
                    bool switchState = _switchState[index] ?? false;
                    return ListTile(
                        title: CustomBucketCard(
                      bucket: bucket,
                      index: index,
                      switchState: switchState,
                      favoriteState: _favoriteState,
                      deleteBucket: deleteBucket,
                      saveFavoriteStateByKey: _saveFavoriteStateByKey,
                      saveSwitchStateByKey: _saveSwitchStateByKey,
                    ));
                  },
                );
              },
            ),
          )
        ]));
  }
}
