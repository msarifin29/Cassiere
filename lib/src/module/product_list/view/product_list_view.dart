import 'package:cassiere/src/shared/constant/app_string.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../models/product_model.dart';
import '../../../service/remote.dart/product_service.dart';
import '../../../shared/constant/app_color.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  Widget build(context, ProductListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product",
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSize.s8, vertical: AppSize.s8),
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(AppColor.whiteColor),
              ),
              onPressed: () => Get.to(const ProductFormView()),
              child: const Text(
                "New product",
                style: TextStyle(color: AppColor.blackColor),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: sizeHeight * 0.8,
        margin: const EdgeInsets.only(top: AppSize.s14),
        child: StreamBuilder(
          stream: ProductService.instance.fetchAllProduct(),
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
                return const Center(child: Text("Product is not available"));
              }
              final item =
                  ProductModel.fromJson(value.data() as Map<String, dynamic>);
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.s12,
                ),
                child: Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          controller.deleteProduct(value.id);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: MdiIcons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          Get.to(ProductFormView(
                            product: item,
                            docId: value.id,
                          ));
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: MdiIcons.pencilOutline,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: AppSize.s100,
                          width: AppSize.s100,
                          margin: const EdgeInsets.all(AppSize.s20),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            image: const DecorationImage(
                              image: AssetImage(AppString.imageOffline),
                            ),
                            borderRadius: BorderRadius.circular(AppSize.s12),
                          ),
                          child: Image.network(item.image!, fit: BoxFit.cover),
                        ),
                        Container(
                          width: sizeWidth * 0.45,
                          padding: const EdgeInsets.only(top: AppSize.s20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title!),
                              Text(
                                  "Rp. ${NumberFormat.currency(locale: 'ID', symbol: "", decimalDigits: 0).format(item.price)}"),
                              Text(item.category!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList());
          },
        ),
      ),
    );
  }

  @override
  State<ProductListView> createState() => ProductListController();
}
