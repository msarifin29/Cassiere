import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';
import '../../../service/hive_service.dart';
import '../../../shared/constant/app_color.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  Widget build(context, ProductListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Product"),
        centerTitle: true,
        actions: const [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: AppSize.s12,
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSize.s20),
            child: ElevatedButton(
              onPressed: () => Get.to(const ProductFormView()),
              child: const Text("New product"),
            ),
          ),
          Container(
            height: sizeHeight * 0.8,
            width: double.infinity,
            margin: const EdgeInsets.only(top: AppSize.s14),
            child: ListView.builder(
              itemCount: HiveProductService.instance.listProducts.length,
              itemBuilder: (context, i) {
                final item = HiveProductService.instance.listProducts[i];
                final title = item["title"];
                final price = item["price"];
                final category = item["category"];
                final description = item["description"];
                print(item["image"].runtimeType);

                return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: AppSize.s100,
                        width: AppSize.s100,
                        margin: const EdgeInsets.all(AppSize.s20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            color: AppColor.grey300),
                      ),
                      const SizedBox(
                        width: AppSize.s24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: AppSize.s20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title),
                            Text("$price"),
                            Text(description),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.deleteProduct(item),
                        icon: const Icon(
                          MdiIcons.delete,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<ProductListView> createState() => ProductListController();
}
