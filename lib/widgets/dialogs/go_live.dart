import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:live_streaming/screens/streaming.dart';
import 'package:file_picker/file_picker.dart';
import 'package:live_streaming/widgets/buttons/popup_dialog_button.dart';
import 'package:live_streaming/widgets/custom_textfield.dart';

class GoLiveDialog extends StatefulWidget {
  const GoLiveDialog({super.key});

  @override
  State<GoLiveDialog> createState() => _GoLiveDialogState();
}

class _GoLiveDialogState extends State<GoLiveDialog> {
  List<String> tags = [
    "Music",
    "Gaming",
    "News",
    "Sports",
    "Movies",
    "Fashion",
    "Food",
    "Travel",
  ];
  String? tagValue;
  String? imageFilePath;
  bool isFileAdded = false;
  final itemEditingController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

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
          CustomTextField(controller: titleController),
          DropdownButtonFormField<String>(
            itemHeight: null,
            dropdownColor: primaryThemeColor,
            decoration: InputDecoration(
              labelText: "Tag",
              labelStyle: const TextStyle(color: secondaryThemeColor),
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
            autofocus: false,
            value: tagValue,
            isExpanded: true,
            iconSize: 28,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: secondaryThemeColor,
            ),
            items: tags.map(buildMenuItem).toList(),
            onChanged: (evalue) => setState(
              () {
                tagValue = evalue;
                itemEditingController.text = evalue!;
              },
            ),
            onSaved: (evalue) {
              itemEditingController.text = evalue!;
            },
            validator: (value) {
              if (itemEditingController.text.isEmpty) {
                return "*Required";
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'Cover Pic',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 4),
          isFileAdded
              ? GestureDetector(
                  onTap: () => setState(() {
                    isFileAdded = false;
                    imageFilePath = null;
                  }),
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
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'jpg', 'png', 'webp']);

                    if (result != null) {
                      setState(() {
                        isFileAdded = true;
                        imageFilePath = result.files.first.path;
                      });
                      print('File path: ' + result.files.single.path!);
                    } else {
                      print('User cancelled file pick');
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
          const SizedBox(height: 20),
          const Text("Let's go live!"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PopupDialogButton(
                  title: "Start Live",
                  onPressed: () => Get.toNamed(StreamingScreen.routeName),
                ),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ));
}
