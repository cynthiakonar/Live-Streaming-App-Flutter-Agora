import 'package:flutter/material.dart';
import 'package:live_streaming/utils/colors.dart';

class PopupDialogButton extends StatelessWidget {
  const PopupDialogButton(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: secondaryThemeColor,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: bgColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
