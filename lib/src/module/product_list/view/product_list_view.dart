import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/service/remote.dart/product_service.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

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
            margin: const EdgeInsets.only(top: AppSize.s14),
            child: StreamBuilder(
              stream: ProductService.instance.firestore.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something wrong...!"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                    children: snapshot.data!.docs.map((value) {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("Product is not available"));
                  }
                  final item = ProductModel.fromJson(
                      value.data() as Map<String, dynamic>);
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
                            color: item.image.isEmpty
                                ? AppColor.grey300
                                : Colors.transparent,
                          ),
                          child: Image.network(item.image),
                        ),
                        Container(
                          width: sizeWidth * 0.5,
                          padding: const EdgeInsets.only(top: AppSize.s20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title),
                              Text(item.price.toString()),
                              Text(item.category),
                            ],
                          ),
                        ),
                        PopupMenuButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: TextButton(
                                onPressed: () {
                                  Get.to(ProductFormView(
                                    products: item,
                                    docId: value.id,
                                  ));
                                },
                                child: const Text("Edit"),
                              ),
                            ),
                            PopupMenuItem(
                              child: TextButton(
                                onPressed: () {
                                  controller.deleteProduct(value.id);
                                },
                                child: const Text("Delete"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList());
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
