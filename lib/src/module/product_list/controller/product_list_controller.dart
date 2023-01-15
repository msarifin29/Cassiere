import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/service/remote_service.dart/product_service.dart';
import 'package:flutter/material.dart';
import '../view/product_list_view.dart';

class ProductListController extends State<ProductListView> {
  static late ProductListController instance;
  late ProductListView view;

  bool isReady = false;
  List<ProductModel> listProduct = [];
  @override
  void initState() {
    instance = this;
    fetchAllProducts();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  fetchAllProducts() async {
    listProduct.clear();
    await ProductService.instance.readAllProduct().then((product) {
      for (var item in product.docs) {
        listProduct.add(ProductModel(
          id: item["id"],
          title: item["title"],
          price: item["price"],
          quantity: item["quantity"],
          category: item["category"],
          description: item["description"],
          image: item["image"],
        ));
      }
    });
  }

  Future<void> deleteProduct(String docId) async {
    await ProductService.instance.deleteProduct(docId: docId);
    setState(() {});
  }
}
