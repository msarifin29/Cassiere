import 'dart:io';

import 'package:cassiere/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

DocumentReference get userCollection {
  final userId = FirebaseAuth.instance.currentUser!;
  return FirebaseFirestore.instance.collection("users").doc(userId.uid);
}

class UserService {
  static createUserIfNotExists() async {
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

  static updatePoint({
    required double point,
  }) async {
    await userCollection.update({
      "point": FieldValue.increment(point),
    });
  }

  static getUserData() {
    var user = {
      "id": FirebaseAuth.instance.currentUser!.uid,
      "email": FirebaseAuth.instance.currentUser!.email,
      "name": FirebaseAuth.instance.currentUser!.displayName,
    };
    return user;
  }

  static editUserName(String name) async {
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

  static uploadPhoto() async {
    final Reference storage = FirebaseStorage.instance.ref();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "png",
        "jpg",
      ],
      allowMultiple: false,
    );
    if (result == null) return;
    File file = File(result.files.single.path!);
    final uploadTask = storage.child('images').putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final dowload = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print("url --------- $dowload");
    }
    try {
      await uploadTask;
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  static editPhoto({String? photo}) async {
    final data = await userCollection.get();
    if (data.exists) {
      return await userCollection.update({
        "photo": photo,
      });
    } else {
      return await userCollection.set({
        "photo": photo,
      });
    }
  }
}
