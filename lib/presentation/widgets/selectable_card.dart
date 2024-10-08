import 'package:flutter/material.dart';

import '../misc/constant.dart';

class SelectableCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isEnable;

  const SelectableCard(
      {super.key,
      required this.text,
      required this.onTap,
      this.isSelected = false,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor.withOpacity(0.3) : null,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: isEnable ? AppColors.primaryColor : Colors.grey)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: isEnable ? AppColors.whiteColor : Colors.grey,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
