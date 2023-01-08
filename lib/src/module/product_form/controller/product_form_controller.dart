// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cassiere/core.dart';
import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/service/remote.dart/firebase_storage_service.dart';
import 'package:cassiere/src/service/remote.dart/product_service.dart';
import 'package:flutter/material.dart';

class ProductFormController extends State<ProductFormView> {
  static late ProductFormController instance;
  late ProductFormView view;

  String title = "";
  double price = 0;
  String description = "";
  String category = "";
  File? image;

  bool isReady = false;
  ProductService productService = ProductService.instance;

  @override
  void initState() {
    instance = this;
    if (widget.products != null) {
      title = widget.products!.title;
      price = widget.products!.price;
      category = widget.products!.category;
      description = widget.products!.description;
      image = File(widget.products!.image);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey();

  bool get isEditMode => widget.products != null;

  Future pickedImage(ImageSource imageSource) async {
    final XFile? imageGalery =
        await ImagePicker().pickImage(source: imageSource);
    if (imageGalery == null) return;
    image = File(imageGalery.path);
    setState(() {});
  }

  String convertUniqeTime() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  void addOrUpdateProduct() async {
    if (!formKey.currentState!.validate()) return;

    if (isEditMode == true) {
      ProductModel products = ProductModel(
          id: widget.products!.id,
          title: title,
          price: price,
          category: category,
          quantity: 1,
          description: description,
          image: widget.products!.image);
      await productService.updateProduct(products.toJson(),
          docId: widget.docId!);
      setState(() {});
      Get.back();
    } else {
      String urlImage =
          await FirebaseStorageService.instance.uploadImage(image!);
      final id = ProductService.instance.firestore.doc();

      ProductModel newProduct = ProductModel(
          id: id.id,
          title: title,
          price: price,
          category: category,
          quantity: 1,
          description: description,
          image: urlImage);
      await productService.addProduct(newProduct.toJson());
      setState(() {});
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
