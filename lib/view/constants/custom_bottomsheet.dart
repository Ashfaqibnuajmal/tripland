import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BottomSheetWidget {
  static void showBottomSheetHome(
    BuildContext context, {
    required List<String> tripType,
    required String? selectedTripType,
    required Function(String?) onTripTypeSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.7),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Gap(10),
                Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 10,
                  runSpacing: 10,
                  children: tripType.map((category) {
                    return ChoiceChip(
                      label: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: selectedTripType == category,
                      onSelected: (isSelected) {
                        onTripTypeSelected(isSelected ? category : null);
                        Navigator.pop(context);
                      },
                      selectedColor: const Color(0xFFFCC300),
                      backgroundColor: Colors.white38,
                    );
                  }).toList(),
                ),
                const Gap(30),
              ],
            ),
          ),
        );
      },
    );
  }
}
