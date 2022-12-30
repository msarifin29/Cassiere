import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../widget/custom_form.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({
    Key? key,
    this.productModels,
  }) : super(key: key);

  final Map? productModels;

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
                    Container(
                      height: AppSize.s200,
                      width: AppSize.s200,
                      decoration: BoxDecoration(
                        color: AppColor.grey300,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      child: controller.image != null
                          ? Image.file(
                              controller.image!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              MdiIcons.cameraOutline,
                              size: AppSize.s36,
                              color: AppColor.whiteColor,
                            ),
                    ),
                    SizedBox(
                      height: AppSize.s40,
                      width: sizeWidth * 0.3,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.pickedImage();
                        },
                        child: const Text("Image"),
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
                    onPressed: () => controller.addProduct(),
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
