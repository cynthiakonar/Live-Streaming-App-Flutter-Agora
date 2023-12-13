import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List image, String uid) async {
    Reference ref = _storage.ref().child(childName).child(uid);
    UploadTask uploadTask = ref.putData(
      image,
      SettableMetadata(
        contentType: 'image/jpg',
      ),
    );
    TaskSnapshot uploadTaskSnapshot = await uploadTask;
    String downloadUrl = await uploadTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
