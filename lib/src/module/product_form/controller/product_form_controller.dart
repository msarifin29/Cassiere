import 'dart:io';

import 'package:cassiere/core.dart';
import 'package:cassiere/src/service/hive_service.dart';
import 'package:flutter/material.dart';

class ProductFormController extends State<ProductFormView> {
  static late ProductFormController instance;
  late ProductFormView view;

  String title = "";
  double price = 0.0;
  String description = "";
  String category = "";
  HiveProductService hiveService = HiveProductService.instance;
  bool isReady = false;
  File? image;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> pickedImage() async {
    final XFile? imageGalery =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(imageGalery!.path);
    // final stringPath = image.path;

    setState(() {});
  }

  addProduct() async {
    if (!formKey.currentState!.validate()) return;
    var result = {
      "title": title,
      "price": price,
      "category": category,
      "description": description,
      "image": image!.path,
    };
    hiveService.add(result);
    setState(() {});
    Get.back();
    print("product :${mainStorage.get(productBox)}");
  }

  void editProduct() async {
    setState(() {});
  }

  void deleteProduct() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
