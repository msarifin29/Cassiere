// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cassiere/core.dart';
import 'package:cassiere/src/service/remote_service.dart/product_service.dart';
import 'package:flutter/material.dart';

class ProductFormController extends State<ProductFormView> {
  static late ProductFormController instance;
  late ProductFormView view;

  String title = "";
  double price = 0;
  String description = "";
  String category = "";
  int quantity = 0;
  // File? image;
  String? imageProduct;
  bool isLoading = false;
  bool isSelected = false;

  ProductService productService = ProductService.instance;

  @override
  void initState() {
    instance = this;

    if (widget.product != null) {
      title = widget.product!.title!;
      price = widget.product!.price!;
      category = widget.product!.category!;
      description = widget.product!.description!;
      imageProduct = widget.product!.image!;
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
    imageProduct = imageGalery.path;
    isSelected = true;
    setState(() {});
  }

  Future<void> addOrUpdateProduct() async {
    if (!formKey.currentState!.validate()) return;

    if (isEditMode == true) {
      if (isSelected == true) {
        final downloadUrl = await productService
            .uploadImage(File(imageProduct!), rootChild: "/images");

        await productService.updateItem(
          idProduct: widget.product!.id!,
          image: downloadUrl,
          title: title,
          price: price,
          quantity: quantity,
          category: category,
          description: description,
          docId: widget.docId!,
        );
      } else {
        await productService.updateItem(
          idProduct: widget.product!.id!,
          image: imageProduct,
          title: title,
          price: price,
          quantity: quantity,
          category: category,
          description: description,
          docId: widget.docId!,
        );
      }
      isLoading = true;
      setState(() {});
      await Get.back();
    } else {
      final id = ProductService.instance.firestore.doc();
      await productService.addProduct(
        id: id.id,
        image: imageProduct,
        title: title,
        price: price,
        quantity: quantity,
        category: category,
        description: description,
      );
      isLoading = true;

      setState(() {});
      await Get.back();
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
