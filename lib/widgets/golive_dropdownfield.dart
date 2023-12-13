import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/controllers/stream_controller.dart';
import 'package:live_streaming/utils/colors.dart';

class GoLiveDropDownField extends StatelessWidget {
  GoLiveDropDownField({super.key});

  StreamController streamController = Get.put(StreamController());

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
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
      value: streamController.tagValue,
      isExpanded: true,
      iconSize: 28,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: secondaryThemeColor,
      ),
      items: streamController.tags.map(buildMenuItem).toList(),
      onChanged: (evalue) {
        streamController.tagValue = evalue;
        streamController.dropdownItemController.text = evalue!;
      },
      onSaved: (evalue) {
        streamController.dropdownItemController.text = evalue!;
      },
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
