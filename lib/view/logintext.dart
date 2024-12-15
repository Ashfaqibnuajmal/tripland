// // // import 'package:flutter/material.dart';

// // // void main() {
// // //   runApp(CheckListApp());
// // // }

// // // class CheckListApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       home: CheckListPage(),
// // //     );
// // //   }
// // // }

// // // class CheckListPage extends StatefulWidget {
// // //   @override
// // //   _CheckListPageState createState() => _CheckListPageState();
// // // }

// // // class _CheckListPageState extends State<CheckListPage> {
// // //   List<Map<String, dynamic>> items = []; // Stores user-input items
// // //   final TextEditingController _controller =
// // //       TextEditingController(); // Controller for text input

// // //   void _addItem(String title) {
// // //     if (title.isNotEmpty) {
// // //       setState(() {
// // //         items.add({"title": title, "isChecked": false});
// // //       });
// // //       _controller.clear(); // Clear the input field
// // //     }
// // //   }

// // //   void _toggleCheck(int index) {
// // //     setState(() {
// // //       items[index]["isChecked"] = !items[index]["isChecked"];
// // //     });
// // //   }

// // //   void _deleteItem(int index) {
// // //     setState(() {
// // //       items.removeAt(index);
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("Checklist"),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.all(8.0),
// // //             child: Row(
// // //               children: [
// // //                 Expanded(
// // //                   child: TextField(
// // //                     controller: _controller,
// // //                     decoration: InputDecoration(
// // //                       labelText: "Enter item",
// // //                       border: OutlineInputBorder(),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 SizedBox(width: 10),
// // //                 ElevatedButton(
// // //                   onPressed: () => _addItem(_controller.text),
// // //                   child: Text("Add"),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           Expanded(
// // //             child: items.isEmpty
// // //                 ? Center(child: Text("No items yet. Add some!"))
// // //                 : ListView.builder(
// // //                     itemCount: items.length,
// // //                     itemBuilder: (context, index) {
// // //                       return Card(
// // //                         child: ListTile(
// // //                           leading: Checkbox(
// // //                             value: items[index]["isChecked"],
// // //                             onChanged: (value) => _toggleCheck(index),
// // //                           ),
// // //                           title: Text(
// // //                             items[index]["title"],
// // //                             style: TextStyle(
// // //                               decoration: items[index]["isChecked"]
// // //                                   ? TextDecoration.lineThrough
// // //                                   : TextDecoration.none,
// // //                             ),
// // //                           ),
// // //                           trailing: IconButton(
// // //                             icon: Icon(Icons.delete, color: Colors.red),
// // //                             onPressed: () => _deleteItem(index),
// // //                           ),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class YourPageName extends StatefulWidget {
// //   const YourPageName({super.key});

// //   @override
// //   State<YourPageName> createState() => _YourPageNameState();
// // }

// // class _YourPageNameState extends State<YourPageName> {
// //   // Helper function to build uniform text fields
// //   Widget _buildTextField(String hintText) {
// //     return Container(
// //       height: 50,
// //       width: 330,
// //       margin: const EdgeInsets.symmetric(vertical: 5),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(5),
// //       ),
// //       child: TextFormField(
// //         textAlign: TextAlign.center,
// //         decoration: InputDecoration(
// //           border: InputBorder.none,
// //           hintText: hintText,
// //           contentPadding: const EdgeInsets.symmetric(horizontal: 10),
// //           hintStyle: const TextStyle(fontSize: 12, color: Colors.black38),
// //         ),
// //       ),
// //     );
// //   }

// //   // Helper function to build row fields with labels
// //   Widget _buildRowFields(String leftLabel, String rightLabel) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 5),
// //       child: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 15),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(leftLabel, style: _whiteTextStyle()),
// //                 Text(rightLabel, style: _whiteTextStyle()),
// //               ],
// //             ),
// //           ),
// //           const Gap(5),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               _buildField("From Time", 150),
// //               _buildField("To Time", 150),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // Helper function to build individual fields
// //   Widget _buildField(String hintText, double width) {
// //     return Container(
// //       height: 50,
// //       width: width,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(5),
// //       ),
// //       child: TextFormField(
// //         textAlign: TextAlign.center,
// //         decoration: InputDecoration(
// //           border: InputBorder.none,
// //           hintText: hintText,
// //           contentPadding: const EdgeInsets.symmetric(horizontal: 10),
// //           hintStyle: const TextStyle(fontSize: 12, color: Colors.black38),
// //         ),
// //       ),
// //     );
// //   }

// //   // Helper function for consistent text styling
// //   TextStyle _whiteTextStyle() {
// //     return GoogleFonts.anton(textStyle: const TextStyle(color: Colors.white));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         title: Text("Your Page Title", style: GoogleFonts.anton(fontSize: 20)),
// //         centerTitle: true,
// //         leading: IconButton(
// //           onPressed: () {},
// //           icon: const Icon(Icons.arrow_back_rounded, size: 25),
// //         ),
// //       ),
// //       body: Center(
// //         child: SingleChildScrollView(
// //           child: Container(
// //             height: 550,
// //             width: 360,
// //             decoration: BoxDecoration(
// //               color: Colors.black87,
// //               borderRadius: BorderRadius.circular(20),
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Gap(40),
// //                   Text("Enter Activity", style: _whiteTextStyle()),
// //                   _buildTextField("Activity Name Here"),
// //                   _buildRowFields("From Time", "To Time"),
// //                   const Gap(10),
// //                   Text("Description", style: _whiteTextStyle()),
// //                   Container(
// //                     height: 100,
// //                     width: 330,
// //                     margin: const EdgeInsets.symmetric(vertical: 5),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(5),
// //                     ),
// //                     child: TextFormField(
// //                       textAlign: TextAlign.center,
// //                       decoration: const InputDecoration(
// //                         border: InputBorder.none,
// //                         hintText: "Brief description here",
// //                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
// //                         hintStyle:
// //                             TextStyle(fontSize: 12, color: Colors.black38),
// //                       ),
// //                     ),
// //                   ),
// //                   const Gap(5),
// //                   Text("Transportation", style: _whiteTextStyle()),
// //                   _buildTextField("Mode of Transport"),
// //                   Center(
// //                     child: Container(
// //                       height: 40,
// //                       width: 80,
// //                       margin: const EdgeInsets.only(top: 10),
// //                       decoration: BoxDecoration(
// //                         color: const Color(0xFFFCC300),
// //                         borderRadius: BorderRadius.circular(50),
// //                       ),
// //                       child: Center(
// //                         child: Text(
// //                           "SAVE",
// //                           style: GoogleFonts.anton(
// //                             color: Colors.black,
// //                             fontSize: 13,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Bucket List',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: Bucketlist(),
// //     );
// //   }
// // }

// class Bucketlist1 extends StatefulWidget {
//   @override
//   _BucketlistState1 createState() => _BucketlistState1();
// }

// class _BucketlistState1 extends State<Bucketlist1> {
//   bool isSwitched = false;

//   final List<Map<String, String>> bucketList = [];

//   // Add a new bucket list item
//   void addNewItem() {
//     setState(() {
//       bucketList.add({
//         'title': 'Himalaya Mountain',
//         'date': '21/12/2024',
//         'category': 'Adventure',
//         'image': 'assets/images/Himalya.png',
//         'description': 'Himalaya is my next dream destination.',
//       });
//     });
//   }

//   // Update the item at the given index
//   void updateItem(int index) {
//     setState(() {
//       bucketList[index]['title'] = 'Updated Title'; // Example update
//     });
//   }

//   // Delete the item at the given index
//   void deleteItem(int index) {
//     setState(() {
//       bucketList.removeAt(index);
//     });
//   }

//   // Show the update confirmation dialog
//   void _showUpdateDialog(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Update Bucket List Item'),
//           content: Text('Are you sure you want to update this item?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 updateItem(index); // Perform the update
//                 Navigator.pop(context); // Close dialog
//               },
//               child: Text('Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Show the delete confirmation dialog
//   void _showDeleteDialog(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Bucket List Item'),
//           content: Text('Are you sure you want to delete this item?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 deleteItem(index); // Perform the delete
//                 Navigator.pop(context); // Close dialog
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Build UI for bucket list
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bucket List"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: addNewItem, // Show the add item button
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: bucketList.length,
//         itemBuilder: (context, index) {
//           final item = bucketList[index];
//           return ListTile(
//             title: Text(item['title']!),
//             subtitle: Text(item['category']!),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     _showUpdateDialog(index); // Show update dialog
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     _showDeleteDialog(index); // Show delete dialog
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: addNewItem, // Add new bucket list item
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
