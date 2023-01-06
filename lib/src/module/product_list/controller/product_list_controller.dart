import 'package:cassiere/src/service/remote.dart/product_service.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/state_util.dart';
import '../view/product_list_view.dart';

class ProductListController extends State<ProductListView>
    implements MvcController {
  static late ProductListController instance;
  late ProductListView view;

  bool isReady = false;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void deleteProduct(String docId) async {
    await ProductService.instance.deleteProduct(docId: docId);
    setState(() {});
  }
}
