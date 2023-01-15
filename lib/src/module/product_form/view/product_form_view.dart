import 'dart:io';

import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/shared/constant/app_string.dart';
import 'package:cassiere/src/shared/utils/info_dialog_reverse.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../../../shared/constant/app_color.dart';
import '../../../shared/utils/validator.dart';
import '../widget/custom_form.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({
    Key? key,
    this.product,
    this.docId,
  }) : super(key: key);

  final ProductModel? product;
  final String? docId;

  Widget build(context, ProductFormController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s20, vertical: AppSize.s30),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                if (controller.isEditMode == true)
                  GestureDetector(
                    onTap: () {
                      controller.pickedImage(ImageSource.gallery);
                    },
                    child: Container(
                      height: AppSize.s200,
                      width: AppSize.s200,
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: controller.imageProduct == null
                          ? Image.asset(
                              AppString.imageOffline,
                              fit: BoxFit.cover,
                            )
                          : controller.imageProduct!.contains("http")
                              ? Image.network(
                                  controller.imageProduct!,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(File(
                                  controller.imageProduct!,
                                )),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () {
                      controller.pickedImage(ImageSource.gallery);
                    },
                    child: Container(
                      height: AppSize.s200,
                      width: AppSize.s200,
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      child: controller.imageProduct != null
                          ? Image.file(File(controller.imageProduct!))
                          : Icon(
                              MdiIcons.camera,
                              color: AppColor.grey300,
                              size: AppSize.s100,
                            ),
                    ),
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
                  value: controller.category,
                  onChanged: (value) {
                    controller.category = value;
                  },
                ),
                CustomForm(
                  textHelper: 'Description',
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
                      controller.addOrUpdateProduct().then((value) {
                        infoDialogReverse(desc: "Succes upload product");
                      });
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
