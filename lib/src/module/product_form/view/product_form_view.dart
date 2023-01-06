import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../widget/custom_form.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({
    Key? key,
    this.products,
    this.docId,
  }) : super(key: key);

  final ProductModel? products;
  final String? docId;

  Widget build(context, ProductFormController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("New Product"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s20, vertical: AppSize.s30),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (controller.isEditMode == true)
                      Container(
                        height: AppSize.s200,
                        width: AppSize.s200,
                        decoration: BoxDecoration(
                          color: AppColor.grey300,
                          borderRadius: BorderRadius.circular(AppSize.s12),
                        ),
                        child: Image.network(products!.image),
                      )
                    else
                      Container(
                        height: AppSize.s200,
                        width: AppSize.s200,
                        decoration: BoxDecoration(
                          color: AppColor.grey300,
                          borderRadius: BorderRadius.circular(AppSize.s12),
                        ),
                        child: controller.image != null
                            ? Image.file(controller.image!)
                            : const Icon(MdiIcons.camera),
                      ),
                    SizedBox(
                      height: AppSize.s40,
                      width: sizeWidth * 0.3,
                      child: Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                controller.pickedImage(
                                                    ImageSource.camera);
                                                await Get.back();
                                              },
                                              icon: const Icon(MdiIcons.camera),
                                              label: const Text('Camera'),
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                controller.pickedImage(
                                                    ImageSource.gallery);
                                                await Get.back();
                                              },
                                              icon: const Icon(
                                                  MdiIcons.fileImage),
                                              label: const Text('Galery'),
                                            ),
                                          ],
                                        ),
                                      ));
                            },
                            child: const Text("Slect Image"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                CustomForm(
                  textHelper: 'Title',
                  validator: Validator.required,
                  value: controller.title,
                  onChanged: (value) {
                    controller.title = value;
                  },
                ),
                CustomForm(
                  textHelper: 'Price',
                  validator: Validator.required,
                  value: controller.price.toString(),
                  inputType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isEmpty) return;
                    controller.price = double.parse(value);
                  },
                ),
                CustomForm(
                  textHelper: 'Category',
                  validator: Validator.required,
                  value: controller.category,
                  onChanged: (value) {
                    controller.category = value;
                  },
                ),
                CustomForm(
                  textHelper: 'Description',
                  validator: Validator.required,
                  value: controller.description,
                  maxLength: 200,
                  maxLines: 4,
                  onChanged: (value) {
                    controller.description = value;
                  },
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                SizedBox(
                  width: sizeWidth * 0.8,
                  height: AppSize.s60,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addOrUpdateProduct();
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<ProductFormView> createState() => ProductFormController();
}
