import 'package:flutter/material.dart';
import 'package:live_streaming/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: 20,
      decoration: InputDecoration(
        isDense: true,
        labelText: "Title",
        labelStyle: const TextStyle(color: secondaryThemeColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: secondaryThemeColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: secondaryThemeColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: secondaryThemeColor),
        ),
      ),
    );
  }
}
