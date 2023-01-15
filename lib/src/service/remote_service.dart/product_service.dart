import 'dart:io';

import 'package:cassiere/src/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ProductService {
  static final ProductService instance = ProductService._();
  factory ProductService() => instance;

  ProductService._();
  String? downloadUrl;

  final userId = FirebaseAuth.instance.currentUser!;
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("products");

  Future<String> uploadImage(
    File? image, {
    required String rootChild,
  }) async {
    final fileName =
        '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
    Reference refDirectoryImage =
        FirebaseStorage.instance.ref().child("/$fileName");
    UploadTask uploadTask = refDirectoryImage.putFile(image!);
    await uploadTask.whenComplete(() async {
      downloadUrl = await refDirectoryImage.getDownloadURL();
    });
    return downloadUrl!;
  }

  Stream<QuerySnapshot> fetchAllProduct() {
    return firestore.snapshots();
  }

  Future<QuerySnapshot> readAllProduct() {
    return firestore.get();
  }

  Future<void> updateProduct(Map<String, dynamic> data,
      {required String docId}) async {
    final docRef = firestore.doc(docId);
    try {
      await docRef.update(data);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future deleteProduct({required String docId}) async {
    try {
      final docRef = firestore.doc(docId);

      await docRef.delete();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<void> addProduct({
    required String id,
    required String? image,
    required String title,
    required double price,
    required int quantity,
    required String category,
    required String description,
  }) async {
    final docId = firestore.doc();
    final downloadImageUrl =
        await uploadImage(File(image!), rootChild: "/images");
    ProductModel item = ProductModel(
        id: id,
        title: title,
        price: price,
        category: category,
        quantity: quantity,
        description: description,
        image: downloadImageUrl);

    try {
      firestore.doc(docId.id).set(item.toJson());
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<void> updateItem({
    required String idProduct,
    required String? image,
    required String title,
    required double price,
    required int quantity,
    required String category,
    required String description,
    required String docId,
  }) async {
    try {
      Map<String, dynamic> data = {
        "id": idProduct,
        "title": title,
        "price": price,
        "quantity": quantity,
        "category": category,
        "description": description,
        "image": image,
      };

      await firestore.doc(docId).update(data);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
}
