import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final FirebaseStorageService instance = FirebaseStorageService._();
  factory FirebaseStorageService() => instance;

  UploadTask? _uploadTask;

  String convertUniqeTime = DateTime.now().microsecondsSinceEpoch.toString();

  Reference fireStore = FirebaseStorage.instance.ref();

  Future uploadImage(File? file, {required String rootChild}) async {
    String url;

    try {
      Reference refDirectoryImage = fireStore.child("/$rootChild");
      final refToUploadImage = refDirectoryImage.child("$convertUniqeTime.jpg");
      _uploadTask = refToUploadImage.putFile(file!);
      final snapshot = await _uploadTask!.whenComplete(() {});
      url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (errror) {}
  }

  // Future uploadImageProduct(File? file) async {
  //   final fileName = File(file!.path);
  //   try {
  //     Reference refDirectoryImage = fireStore.child("/images");
  //     final refToUploadImage =
  //         refDirectoryImage.child("$convertUniqeTime.image");
  //     _uploadTask = refToUploadImage.putFile(fileName);
  //     final snapshot = await _uploadTask!.whenComplete(() {});
  //     return await snapshot.ref.getDownloadURL();
  //   } catch (errror) {}
  // }

  Future updateImage(String urlUmage) async {
    try {
      Reference refDirectoryImage =
          FirebaseStorage.instance.refFromURL(urlUmage);
      return refDirectoryImage;
    } catch (error) {}
  }
}
