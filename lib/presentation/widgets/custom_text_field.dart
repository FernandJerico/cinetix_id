import 'package:flutter/material.dart';

import '../misc/constant.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.whiteColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade800)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.whiteColor)),
      ),
    );
  }
}
