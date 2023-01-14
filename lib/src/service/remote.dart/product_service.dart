import 'dart:io';

import 'package:cassiere/src/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  static final ProductService instance = ProductService._();
  factory ProductService() => instance;

  ProductService._();

  bool isLoading = false;
  final userId = FirebaseAuth.instance.currentUser!;
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("products");

  Future<String> uploadImage(File? image, {required String rootChild}) async {
    int convertUniqeTime = DateTime.now().microsecondsSinceEpoch;
    Reference refDirectoryImage =
        FirebaseStorage.instance.ref().child("/$rootChild");
    final refToUploadImage = refDirectoryImage.child("$convertUniqeTime.jpg");
    UploadTask uploadTask = refToUploadImage.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
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
    } catch (error) {}
  }

  Future deleteProduct({required String docId}) async {
    try {
      final docRef = firestore.doc(docId);

      await docRef.delete();
    } catch (error) {}
  }

  Future<void> additem({
    required String id,
    required File? image,
    required String title,
    required double price,
    required int quantity,
    required String category,
    required String description,
  }) async {
    isLoading = true;
    final docId = firestore.doc();
    final downloadImageUrl = await uploadImage(image, rootChild: "images");
    ProductModel item = ProductModel(
        id: id,
        title: title,
        price: price,
        category: category,
        quantity: quantity,
        description: description,
        image: downloadImageUrl);
    // item.id = id;
    // item.title = title;
    // item.price = price;
    // item.category = category;
    // item.quantity = quantity;
    // item.description = description;
    // item.image = downloadImageUrl;
    try {
      firestore.doc(docId.id).set(item.toJson());
    } catch (error) {}
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
    isLoading = true;
    // final downloadImageUrl = await uploadImage(image, rootChild: "images");

    try {
      firestore.doc(docId).update({
        "id": idProduct,
        "title": title,
        "price": price,
        "quantity": quantity,
        "category": category,
        "description": description,
        "images": image,
      });
    } catch (error) {}
  }
}
