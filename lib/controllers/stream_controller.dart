import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_streaming/controllers/setup_controller.dart';
import 'package:live_streaming/models/livestream.dart';
import 'package:live_streaming/models/user.dart';
import 'package:live_streaming/resources/storage_methods.dart';
import 'package:live_streaming/utils/utils.dart';

class StreamController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

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
  Uint8List? imageFilePath;
  RxBool isFileAdded = false.obs;
  final TextEditingController dropdownItemController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    tagValue = null;
    imageFilePath = null;
    isFileAdded(false);
    dropdownItemController.dispose();
    titleController.dispose();
    super.dispose();
  }

  Future<String> startLiveStream(
    BuildContext context,
    String title,
    String? tag,
    Uint8List? image,
  ) async {
    User user = await SetupController().setUser();
    String channelId = '';

    try {
      if (title.isNotEmpty && tag != null && image != null) {
        if (!((await _firestore
                .collection('live_streams')
                .doc('${user.uid}${user.username}')
                .get())
            .exists)) {
          String thumnailUrl = await _storageMethods.uploadImageToStorage(
            'livestream-thumbnails',
            image,
            user.uid,
          );
          channelId = '${user.uid}${user.username}'; // useridusername
          LiveStream liveStream = LiveStream(
            title: title,
            tag: tag,
            image: thumnailUrl,
            uid: user.uid,
            username: user.username,
            viewers: 0,
            channelId: channelId,
            startedAt: DateTime.now(),
          );

          _firestore
              .collection('live_streams')
              .doc(channelId)
              .set(liveStream.toMap());

          dispose();
        } else {
          showSnackBar(context, 'You are already streaming');
        }
      } else {
        showSnackBar(context, 'Please fill all the fields');
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
    return channelId;
  }

  Future<void> updateViewCount(String id, bool isIncreaded) async {
    try {
      await _firestore.collection('live_streams').doc(id).update({
        'viewers': FieldValue.increment(isIncreaded ? 1 : -1),
      });
    } on FirebaseException catch (e) {
      debugPrint(e.message!);
    }
  }

  Future<void> endLiveStream(String channelId) async {
    try {
      await _firestore.collection('live_streams').doc(channelId).delete();
      print("hi");
    } on FirebaseException catch (e) {
      showSnackBar(Get.context!, e.message!);
    }
  }
}
