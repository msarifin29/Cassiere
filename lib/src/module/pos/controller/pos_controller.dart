import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/service/remote.dart/product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'dart:math';
import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PosController extends State<PosView> implements MvcController {
  static late PosController instance;
  late PosView view;

  List<ProductModel> listProduct = [];
  @override
  void initState() {
    fetchAllProduct();
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void fetchAllProduct() async {
    var result = await ProductService.instance.fetchAllProduct();
    final item = result.docs
        .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>));
    listProduct = item.toList();
    setState(() {});
    print(listProduct);
  }

  List products = [
    {
      "id": 1,
      "photo":
          "https://i.ibb.co/dG68KJM/photo-1513104890138-7c749659a591-crop-entropy-cs-tinysrgb-fit-max-fm-jpg-ixid-Mnwy-ODA4-ODh8-MHwxf-H.jpg",
      "product_name": "Frenzy Pizza",
      "price": 25,
      "category": "Food",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
    {
      "id": 2,
      "photo":
          "https://i.ibb.co/mHtmhmP/photo-1521305916504-4a1121188589-crop-entropy-cs-tinysrgb-fit-max-fm-jpg-ixid-Mnwy-ODA4-ODh8-MHwxf-H.jpg",
      "product_name": "Beef Burger",
      "price": 22,
      "category": "Food",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
    {
      "id": 3,
      "photo":
          "https://images.unsplash.com/photo-1625869016774-3a92be2ae2cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
      "product_name": "Seperait",
      "price": 33,
      "category": "Drink",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
  ];

  doCheckout() async {
    //Atur point menjadi 10% dari total
    var qrCodeString = jsonEncode({
      "total": Random().nextInt(3000),
      "point": Random().nextInt(3000),
      "items": products,
      "payment_method": "Cash", //Dana | OVO | Gopay
      "vendor": {
        "id": FirebaseAuth.instance.currentUser!.uid,
        "email": FirebaseAuth.instance.currentUser!.email,
        "name": FirebaseAuth.instance.currentUser!.displayName,
      }
    });

    await showCustomDialog(
      title: "Order success",
      children: [
        SizedBox(
          height: 120.0,
          width: 120.0,
          child: QrImage(
            data: qrCodeString,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
      ],
    );
    Get.back();
  }
}
