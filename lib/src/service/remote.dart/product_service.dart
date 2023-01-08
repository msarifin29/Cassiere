import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductService {
  static final ProductService instance = ProductService._();
  factory ProductService() => instance;

  ProductService._();

  final userId = FirebaseAuth.instance.currentUser!;
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("products");

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
