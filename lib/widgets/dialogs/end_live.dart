import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/controllers/stream_controller.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:live_streaming/widgets/buttons/popup_dialog_button.dart';

class EndLiveDialog extends StatelessWidget {
  const EndLiveDialog({super.key, required this.channelId});
  final String channelId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryThemeColor.withOpacity(0.7),
      title: const Text(
        "End Live",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Are you sure you want to end the live?"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PopupDialogButton(
                  title: "Confirm",
                  onPressed: () async =>
                      await StreamController().endLiveStream(channelId),
                ),
              ),
              Expanded(
                child: PopupDialogButton(
                    title: "Cancel", onPressed: () => Get.back()),
              )
            ],
          )
        ],
      ),
    );
  }
}
