import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/service/local_service.dart/hive_service.dart';
import 'package:cassiere/src/service/remote_service.dart/product_service.dart';
import 'dart:convert';
import 'package:cassiere/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PosController extends State<PosView> {
  static late PosController instance;
  late PosView view;

  List<ProductModel> listProduct = [];

  final HiveProductService _hiveProductService = HiveProductService.instance;

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
    var result = await ProductService.instance.readAllProduct();
    final item = result.docs
        .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>));

    if (_hiveProductService.getProducts().isNotEmpty) {
      // get product from Api
      listProduct = item.toList();
    }
    // Save products to local db
    _hiveProductService.assignAllProduct(products: item.toList());
    setState(() {});
  }

  double get totalPrice {
    double subtotal = 0.0;
    for (var i = 0; i < listProduct.length; i++) {
      if (listProduct[i].price != 0) {
        subtotal += listProduct[i].quantity * listProduct[i].price!.toInt();
      }
    }
    return subtotal;
  }

  checkOutPayment() async {
    //Atur point menjadi 10% dari total
    var qrCodeString = jsonEncode({
      "total": totalPrice,
      "point": totalPrice * 10 / 100,
      // "items": listProduct,
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
          height: 300.0,
          width: 300,
          child: QrImage(
            data: qrCodeString,
            version: QrVersions.auto,
            // size: 350.0,
          ),
        ),
      ],
    );
    Get.back();
  }
}
