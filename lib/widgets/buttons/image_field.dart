import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/controllers/stream_controller.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:live_streaming/utils/utils.dart';

class ImageField extends StatelessWidget {
  ImageField({super.key});

  StreamController streamController = Get.put(StreamController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => streamController.isFileAdded.value
          ? GestureDetector(
              onTap: () {
                streamController.isFileAdded(false);
                streamController.imageFilePath = null;
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: secondaryThemeColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Image uploaded',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(
                      Icons.close,
                      size: 20,
                    )
                  ],
                ),
              ),
            )
          : GestureDetector(
              onTap: () async {
                Uint8List? pickedImage = await pickImage();
                if (pickedImage != null) {
                  streamController.isFileAdded(true);
                  streamController.imageFilePath = pickedImage;
                } else {
                  showSnackBar(context, 'User cancelled file pick');
                }
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: secondaryThemeColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Icon(Icons.upload_file_rounded),
                ),
              ),
            ),
    );
  }
}
