import 'package:cassiere/src/models/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveProductService {
  static final HiveProductService instance = HiveProductService._();
  factory HiveProductService() => instance;
  HiveProductService._();
  late Box<ProductModel> productBox;

  Future<void> init() async {
    // productBox = await Hive.openBox<ProductModel>("productBox");
    await Hive.initFlutter();
    Hive.registerAdapter(ProductModelAdapter());
    HiveProductService.instance.productBox =
        await Hive.openBox<ProductModel>("productBox");
  }

  Future<void> assignAllProduct({required List<ProductModel> products}) async {
    await productBox.clear();
    await productBox.addAll(products);
  }

  List<ProductModel> getProducts() => productBox.values.toList();
}
