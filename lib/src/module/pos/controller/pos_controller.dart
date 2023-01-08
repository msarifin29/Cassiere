import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/service/remote.dart/product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
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
  }

  double get totalPrice {
    double subtotal = 0.0;
    for (var i = 0; i < listProduct.length; i++) {
      if (listProduct[i].price != 0) {
        subtotal += listProduct[i].quantity * listProduct[i].price.toInt();
      }
    }
    return subtotal;
  }

  checkOutPayment() async {
    //Atur point menjadi 10% dari total
    var qrCodeString = jsonEncode({
      "total": totalPrice,
      "point": totalPrice * 10 / 100,
      "items": listProduct,
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
