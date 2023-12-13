import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/controllers/stream_controller.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:live_streaming/screens/streaming.dart';
import 'package:live_streaming/utils/utils.dart';
import 'package:live_streaming/widgets/buttons/image_field.dart';
import 'package:live_streaming/widgets/buttons/popup_dialog_button.dart';
import 'package:live_streaming/widgets/golive_dropdownfield.dart';
import 'package:live_streaming/widgets/custom_textfield.dart';

class GoLiveDialog extends StatefulWidget {
  const GoLiveDialog({super.key});

  @override
  State<GoLiveDialog> createState() => _GoLiveDialogState();
}

class _GoLiveDialogState extends State<GoLiveDialog> {
  StreamController streamController = Get.put(StreamController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryThemeColor.withOpacity(0.7),
      title: const Text(
        "Go Live",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(controller: streamController.titleController),
          GoLiveDropDownField(),
          const SizedBox(height: 12),
          const Text(
            'Cover Pic',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 4),
          ImageField(),
          const SizedBox(height: 20),
          const Text("Let's go live!"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PopupDialogButton(
                    title: "Start Live",
                    onPressed: () async {
                      String channelId = await streamController.startLiveStream(
                          context,
                          streamController.titleController.text,
                          streamController.tagValue,
                          streamController.imageFilePath);

                      if (channelId.isNotEmpty) {
                        showSnackBar(context, "Live Stream Started");
                        Get.to(
                          StreamingScreen(
                              isBroadcaster: true, channelId: channelId),
                        );
                      }
                    }),
              ),
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
