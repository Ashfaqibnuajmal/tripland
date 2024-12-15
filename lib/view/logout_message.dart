import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogoutMessage extends StatelessWidget {
  const LogoutMessage({super.key});

  void deleteItem() {
    print('Item deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logout message')),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.logout_rounded),
          onPressed: () => showLogoutDialog(context, deleteItem),
        ),
      ),
    );
  }
}

Future<void> showLogoutDialog(BuildContext context, VoidCallback onDelete) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.black87,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.report_gmailerrorred_outlined,
                size: 30, color: Colors.redAccent),
            const Gap(10),
            const Text('Logout?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const Gap(10),
            const Text(
              "Are you sure you want to logout?",
              style: TextStyle(color: Colors.white),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(ctx, 'Cancel', Colors.black, Colors.white,
                    () => Navigator.of(ctx).pop()),
                button(ctx, 'Logout', Colors.redAccent, Colors.white, () {
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
