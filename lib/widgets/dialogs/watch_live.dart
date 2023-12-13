import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/screens/streaming.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:live_streaming/widgets/buttons/popup_dialog_button.dart';

class WatchLiveDialog extends StatelessWidget {
  const WatchLiveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryThemeColor.withOpacity(0.7),
      title: const Text(
        "Watch Live",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              "You will now watch user A's live stream. Do you wish to continue?"),
          const SizedBox(height: 16),
          Row(
            children: [
              // Expanded(
              //   child: PopupDialogButton(
              //     title: "Continue",
              //     onPressed: () => Get.to(StreamingScreen(
              //       isBroadcaster: false,
              //       channelId: channelId,
              //     )),
              //   ),
              // ),
              Expanded(
                child: PopupDialogButton(
                  title: "Cancel",
                  onPressed: () => Get.back(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
