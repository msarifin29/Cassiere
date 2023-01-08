import 'package:hive_flutter/hive_flutter.dart';

late Box mainStorage;

const String productBox = "products";

class HiveProductService {
  static final HiveProductService instance = HiveProductService._();
  factory HiveProductService() => instance;
  HiveProductService._();
  List listProducts = [];

  save() async {
    mainStorage.put(productBox, listProducts);
  }

  load() async {
    listProducts = mainStorage.get(productBox) ?? [];
  }

  add(Map newProduct) async {
    listProducts.add(newProduct);
    await save();
  }

  delete(Map product) async {
    listProducts.remove(product);
    await save();
  }

  update(int index, Map newProduct) async {
    listProducts[index] = newProduct;
    await save();
  }

  initializerHiveDB() async {}
}
