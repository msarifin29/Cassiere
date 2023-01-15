import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

DocumentReference get userCollection {
  final userId = FirebaseAuth.instance.currentUser!;
  return FirebaseFirestore.instance.collection("users").doc(userId.uid);
}

class UserService {
  UserService._();
  static final UserService instance = UserService._();
  factory UserService() => instance;

  UploadTask? _uploadTask;

  String convertUniqeTime = DateTime.now().microsecondsSinceEpoch.toString();

  Reference fireStore = FirebaseStorage.instance.ref();

  Future<void> createUserIfNotExists() async {
    var snapshot = await userCollection.get();
    if (!snapshot.exists) {
      await userCollection.set({
        "id": FirebaseAuth.instance.currentUser!.uid,
        "photo": FirebaseAuth.instance.currentUser!.photoURL,
        "email": FirebaseAuth.instance.currentUser!.email,
        "name": FirebaseAuth.instance.currentUser!.displayName,
        "point": 0,
      });
    }
  }

  Future<void> updatePoint({
    required double point,
  }) async {
    await userCollection.update({
      "point": point, // FieldValue.increment(point)
    });
  }

  getUserData() {
    var user = {
      "id": FirebaseAuth.instance.currentUser!.uid,
      "email": FirebaseAuth.instance.currentUser!.email,
      "name": FirebaseAuth.instance.currentUser!.displayName,
    };
    return user;
  }

  Future<void> editUserName(String name) async {
    final data = await userCollection.get();
    if (data.exists) {
      return await userCollection.update({
        "name": name,
      });
    } else {
      return await userCollection.set({
        "name": name,
      });
    }
  }

  Future uploadImage(File? file, {required String rootChild}) async {
    String url;

    try {
      Reference refDirectoryImage = fireStore.child("/$rootChild");
      final refToUploadImage = refDirectoryImage.child("$convertUniqeTime.jpg");
      _uploadTask = refToUploadImage.putFile(file!);
      final snapshot = await _uploadTask!.whenComplete(() {});
      url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<void> updateProfile({required String imageUrl}) async {
    final data = await userCollection.get();
    if (data.exists) {
      return await userCollection.update({
        "photo": imageUrl,
      });
    } else {
      return await userCollection.set({
        "photo": imageUrl,
      });
    }
  }
}
