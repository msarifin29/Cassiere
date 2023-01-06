import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  static final ProductService instance = ProductService._();
  factory ProductService() => instance;

  ProductService._();

  UploadTask? _uploadTask;
  final userId = FirebaseAuth.instance.currentUser!;
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("products");

  String convertUniqeTime = DateTime.now().millisecondsSinceEpoch.toString();

  // Using firebase storage
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

  // Using firebase storage
  Future updateImage(String urlUmage) async {
    try {
      Reference refDirectoryImage =
          FirebaseStorage.instance.refFromURL(urlUmage);
      return refDirectoryImage;
    } catch (error) {}
  }

  Future<void> addProduct(Map<String, dynamic> data) async {
    try {
      await firestore.add(data);
    } catch (error) {}
  }

  Future<QuerySnapshot> fetchAllProduct() async {
    return await firestore.get();
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
}
