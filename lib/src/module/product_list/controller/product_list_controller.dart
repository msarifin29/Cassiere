import 'package:flutter/material.dart';
import 'package:cassiere/state_util.dart';
import '../../../service/hive_service.dart';
import '../view/product_list_view.dart';

class ProductListController extends State<ProductListView>
    implements MvcController {
  static late ProductListController instance;
  late ProductListView view;

  bool isReady = false;

  @override
  void initState() {
    readAllProduct();
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  Future<void> readAllProduct() async {
    isReady = true;
    HiveProductService.instance.load();
    setState(() {});
  }

  void deleteProduct(Map products) async {
    HiveProductService.instance.delete(products);
    setState(() {});
  }
}
