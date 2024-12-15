import 'package:flutter/material.dart';

class DeleteMessageWidget extends StatelessWidget {
  const DeleteMessageWidget({super.key});

  void deleteItem() {
    print('Item deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Dialog Example')),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => showDeleteDialog(context, deleteItem),
        ),
      ),
    );
  }
}

Future<void> showDeleteDialog(BuildContext context, VoidCallback onDelete) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.black54,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.report_gmailerrorred_outlined,
                size: 30, color: Colors.red),
            const SizedBox(height: 10),
            const Text('Delete Photo?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const SizedBox(height: 10),
            const Text(
              "Are you sure you want to delete  this photo?",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(ctx, 'Cancel', Colors.white12, Colors.white,
                    () => Navigator.of(ctx).pop()),
                button(ctx, 'Delete', Colors.redAccent, Colors.white, () {
                  onDelete();
                  Navigator.of(ctx).pop();
                }),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget button(BuildContext ctx, String text, Color bgColor, Color textColor,
    VoidCallback onPressed) {
  return Container(
    height: 40,
    width: 90,
    decoration:
        BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(5)),
    child: TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    ),
  );
}
