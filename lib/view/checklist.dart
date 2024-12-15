import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Checklist extends StatefulWidget {
  const Checklist({super.key});

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  List<Map<String, dynamic>> items = [];

  void _toggleCheck(int index) {
    setState(() {
      items[index]["isChecked"] = !items[index]["isChecked"];
    });
  }

  void addItemDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black54,
        title: const Center(
          child: Text("Add Item",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        content: Container(
          height: 80,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: _controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter item",
              contentPadding: EdgeInsets.only(top: 20),
              hintStyle: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    setState(() {
                      items.add({
                        "title": _controller.text,
                        "isChecked": false,
                      });
                    });
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter an item")),
                    );
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void bottomSheetHome(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Checklist", style: GoogleFonts.anton(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            bottomSheetHome(context);
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () => addItemDialog(context),
            icon: const Icon(Icons.library_add_check_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          const Gap(40),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text(
                        "Your checklist is empty. Add something to get started!"),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 2.0),
                        child: Card(
                          color: const Color(0xFFF0F4F8),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: items[index]["isChecked"],
                              onChanged: (value) => _toggleCheck(index),
                              activeColor: Colors.black,
                              checkColor: Colors.white,
                            ),
                            title: Text(
                              items[index]["title"],
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
