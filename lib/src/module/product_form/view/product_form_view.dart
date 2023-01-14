import 'package:cassiere/src/models/product_model.dart';
import 'package:cassiere/src/module/product_form/widget/select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../../../shared/constant/app_color.dart';
import '../widget/custom_form.dart';

// class ProductFormView extends StatefulWidget {
//   const ProductFormView({
//     Key? key,
//     this.products,
//     this.docId,
//   }) : super(key: key);

//   final ProductModel? products;
//   final String? docId;

//   Widget build(context, ProductFormController controller) {
//     controller.view = this;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Product"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//               horizontal: AppSize.s20, vertical: AppSize.s30),
//           child: Form(
//             key: controller.formKey,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: controller.isEditMode == true
//                       ? MainAxisAlignment.center
//                       : MainAxisAlignment.spaceAround,
//                   children: [
//                     if (controller.isEditMode == true)
//                       Container(
//                         height: AppSize.s200,
//                         width: AppSize.s200,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(products!.image!),
//                           ),
//                           border: Border.all(),
//                           borderRadius: BorderRadius.circular(AppSize.s12),
//                         ),
//                       )
//                     else
//                       Container(
//                         height: AppSize.s200,
//                         width: AppSize.s200,
//                         decoration: BoxDecoration(
//                           border: Border.all(),
//                           borderRadius: BorderRadius.circular(AppSize.s12),
//                         ),
//                         child: controller.image != null
//                             ? Image.file(controller.image!)
//                             : Icon(
//                                 MdiIcons.camera,
//                                 color: AppColor.grey300,
//                                 size: AppSize.s100,
//                               ),
//                       ),
//                     controller.isEditMode == false
//                         ? SizedBox(
//                             height: AppSize.s40,
//                             width: sizeWidth * 0.3,
//                             child: Builder(
//                               builder: (context) {
//                                 return ElevatedButton(
//                                   onPressed: () {
//                                     selectDialog(
//                                         iconFirst: MdiIcons.camera,
//                                         titleFirst: "Camera",
//                                         onPressedFirst: () async {
//                                           controller
//                                               .pickedImage(ImageSource.camera);
//                                           await Get.back();
//                                         },
//                                         iconSecond: MdiIcons.fileImage,
//                                         titleSecond: "Galery",
//                                         onPressedSecond: () async {
//                                           controller
//                                               .pickedImage(ImageSource.gallery);
//                                           await Get.back();
//                                         });
//                                   },
//                                   child: const Text("Select Image"),
//                                 );
//                               },
//                             ),
//                           )
//                         : const SizedBox(),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: AppSize.s20,
//                 ),
//                 CustomForm(
//                   textHelper: 'Title',
//                   validator: Validator.required,
//                   value: controller.title,
//                   onChanged: (value) {
//                     controller.title = value;
//                   },
//                 ),
//                 CustomForm(
//                   textHelper: 'Price',
//                   validator: Validator.required,
//                   value: controller.price.toString(),
//                   inputType: TextInputType.number,
//                   onChanged: (value) {
//                     if (value.isEmpty) return;
//                     controller.price = double.parse(value);
//                   },
//                 ),
//                 CustomForm(
//                   textHelper: 'Category',
//                   value: controller.category,
//                   onChanged: (value) {
//                     controller.category = value;
//                   },
//                 ),
//                 CustomForm(
//                   textHelper: 'Description',
//                   value: controller.description,
//                   maxLength: 200,
//                   maxLines: 4,
//                   onChanged: (value) {
//                     controller.description = value;
//                   },
//                 ),
//                 const SizedBox(
//                   height: AppSize.s40,
//                 ),
//                 SizedBox(
//                   width: sizeWidth * 0.8,
//                   height: AppSize.s60,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       controller.addOrUpdateProduct();
//                     },
//                     child: const Text("Save"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   State<ProductFormView> createState() => ProductFormController();
// }

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
                Row(
                  mainAxisAlignment: controller.isEditMode == true
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    if (controller.isEditMode == true)
                      Container(
                        height: AppSize.s200,
                        width: AppSize.s200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(product!.image!),
                          ),
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(AppSize.s12),
                        ),
                      )
                    else
                      Container(
                        height: AppSize.s200,
                        width: AppSize.s200,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(AppSize.s12),
                        ),
                        child: controller.image != null
                            ? Image.file(controller.image!)
                            : Icon(
                                MdiIcons.camera,
                                color: AppColor.grey300,
                                size: AppSize.s100,
                              ),
                      ),
                    controller.isEditMode == false
                        ? SizedBox(
                            height: AppSize.s40,
                            width: sizeWidth * 0.3,
                            child: Builder(
                              builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    selectDialog(
                                        iconFirst: MdiIcons.camera,
                                        titleFirst: "Camera",
                                        onPressedFirst: () async {
                                          controller
                                              .pickedImage(ImageSource.camera);
                                          await Get.back();
                                        },
                                        iconSecond: MdiIcons.fileImage,
                                        titleSecond: "Galery",
                                        onPressedSecond: () async {
                                          controller
                                              .pickedImage(ImageSource.gallery);
                                          await Get.back();
                                        });
                                  },
                                  child: const Text("Select Image"),
                                );
                              },
                            ),
                          )
                        : const SizedBox(),
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
