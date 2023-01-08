import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final FirebaseStorageService instance = FirebaseStorageService._();
  factory FirebaseStorageService() => instance;

  UploadTask? _uploadTask;

  String convertUniqeTime = DateTime.now().millisecondsSinceEpoch.toString();

  Future uploadImage(File? file) async {
    final fileName = File(file!.path);
    try {
      Reference refDirectoryImage =
          FirebaseStorage.instance.ref().child("images");
      final refToUploadImage = refDirectoryImage.child(convertUniqeTime);
      _uploadTask = refToUploadImage.putFile(fileName);
      final snapshot = await _uploadTask!.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } catch (errror) {}
  }

  Future updateImage(String urlUmage) async {
    try {
      Reference refDirectoryImage =
          FirebaseStorage.instance.refFromURL(urlUmage);
      return refDirectoryImage;
    } catch (error) {}
  }
}
