// ignore_for_file: invalid_use_of_protected_member

import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../widget/card_pos_product.dart';

class PosView extends StatefulWidget {
  const PosView({Key? key}) : super(key: key);

  Widget build(context, PosController controller) {
    controller.view = this;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Casir"), centerTitle: true),
      body: SizedBox(
        height: size.height * 0.7,
        child: ListView.builder(
          itemCount: controller.listProduct.length,
          itemBuilder: (context, index) {
            final item = controller.listProduct[index];
            return CardPosProduct(
              item: item,
              decrementQuantity: () {
                if (item.quantity > 0) {
                  item.quantity--;
                  controller.setState(() {});
                }
              },
              incrementQuantity: () {
                item.quantity++;
                controller.setState(() {});
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s20),
            topRight: Radius.circular(AppSize.s20),
          ),
        ),
        height: size.height * 0.23,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.s20, vertical: AppSize.s8),
              child: Text(
                  "Total : Rp. ${NumberFormat.currency(locale: 'ID', symbol: "", decimalDigits: 0).format(controller.totalPrice)}",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            Container(
              height: size.height * 0.08,
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
              margin: const EdgeInsets.symmetric(horizontal: AppSize.s20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child: CustomDropdownField(
                label: "Select Payment",
                items: const [
                  {
                    "label": "Cash",
                    "value": 1,
                  },
                  {
                    "label": "Credit Card",
                    "value": 2,
                  },
                  {
                    "label": "OVO",
                    "value": 3,
                  },
                  {
                    "label": "Dana",
                    "value": 4,
                  }
                ],
                onChanged: (value, label) {},
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppSize.s20, vertical: AppSize.s8),
              width: MediaQuery.of(context).size.width,
              height: AppSize.s50,
              child: ElevatedButton.icon(
                icon: const Icon(MdiIcons.checkCircle),
                label: const Text("Checkout"),
                onPressed: () async {
                  await controller.checkOutPayment();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<PosView> createState() => PosController();
}
