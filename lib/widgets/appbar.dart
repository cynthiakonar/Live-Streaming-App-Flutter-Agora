import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset("assets/images/live_logo_icon.jpg"),
          ),
        ),
        const SizedBox(width: 20)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
