// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cassiere/core.dart';
import 'package:cassiere/src/service/remote.dart/product_service.dart';
import 'package:flutter/material.dart';

class ProductFormController extends State<ProductFormView> {
  static late ProductFormController instance;
  late ProductFormView view;

  String title = "";
  double price = 0;
  String description = "";
  String category = "";
  int quantity = 0;
  File? image;
  bool isLoading = false;
  ProductService productService = ProductService.instance;

  @override
  void initState() {
    instance = this;

    if (widget.product != null) {
      title = widget.product!.title!;
      price = widget.product!.price!;
      category = widget.product!.category!;
      description = widget.product!.description!;
      image = File(widget.product!.image!);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey();

  bool get isEditMode => widget.product != null;

  Future pickedImage(ImageSource imageSource) async {
    final XFile? imageGalery =
        await ImagePicker().pickImage(source: imageSource);
    if (imageGalery == null) return;
    image = File(imageGalery.path);

    setState(() {});
  }

  // String convertUniqeTime() {
  //   return DateTime.now().millisecondsSinceEpoch.toString();
  // }

  void addOrUpdateProduct() async {
    if (!formKey.currentState!.validate()) return;
    // final urlImage = await FirebaseStorageService.instance
    //     .uploadImage(image!, rootChild: "images");
    if (isEditMode == true) {
      isLoading = true;

      // ProductModel products = ProductModel(
      //   id: widget.products!.id,
      //   title: title,
      //   price: price,
      //   category: category,
      //   quantity: quantity,
      //   description: description,
      //   image: widget.products!.image,
      // );
      // await productService.updateProduct(products.toJson(),
      //     docId: widget.docId!);
      // await productService.updateItem(
      //     idProduct: widget.products!.id!,
      //     image: File(widget.products!.image!),
      //     title: title,
      //     price: price,
      //     quantity: quantity,
      //     category: category,
      //     description: description,
      //     docId: widget.docId!);
      await productService.updateItem(
          idProduct: widget.product!.id!,
          image: widget.product!.image!,
          title: title,
          price: price,
          quantity: quantity,
          category: category,
          description: description,
          docId: widget.docId!);
      setState(() {});
      Get.back();
    } else {
      isLoading = true;

      final id = ProductService.instance.firestore.doc();
      await productService.additem(
          id: id.id,
          image: image,
          title: title,
          price: price,
          quantity: quantity,
          category: category,
          description: description);
      // ProductModel newProduct = ProductModel(
      //     id: id.id,
      //     title: title,
      //     price: price,
      //     category: category,
      //     quantity: quantity,
      //     description: description,
      //     image: urlImage);
      // await productService.addProduct(newProduct.toJson());
      setState(() {});
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
