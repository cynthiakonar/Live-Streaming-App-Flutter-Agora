import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/constants/colors.dart';
import 'package:live_streaming/screens/watch_live.dart';

class WatchLiveDialog extends StatelessWidget {
  const WatchLiveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryThemeColor.withOpacity(0.7),
      title: const Text(
        "Watch Live",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: const Text(
        "You will now watch user A's live stream. Do you wish to continue?",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Get.to(() => const WatchLiveScreen());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: const Text(
              "Continue",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
