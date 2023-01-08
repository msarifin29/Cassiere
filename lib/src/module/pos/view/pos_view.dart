// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../widget/card_pos_product.dart';

class PosView extends StatefulWidget {
  const PosView({Key? key}) : super(key: key);

  Widget build(context, PosController controller) {
    controller.view = this;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Pos"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.75,
              child: ListView.builder(
                itemCount: controller.listProduct.length,
                itemBuilder: (context, index) {
                  final item = controller.listProduct[index];
                  return CardPosProduct(
                    item: item,
                    decrementQuantity: () {
                      if (item.quantity > 0) {
                        item.quantity--;
                      }
                      controller.setState(() {});
                    },
                    incrementQuantity: () {
                      item.quantity++;
                      controller.setState(() {});
                    },
                  );
                },
              ),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: AppSize.s50),
                  child: Text(
                      "Total : Rp. ${NumberFormat.currency(locale: 'ID', symbol: "", decimalDigits: 0).format(controller.totalPrice)}",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppSize.s20, vertical: AppSize.s8),
                  width: MediaQuery.of(context).size.width,
                  height: AppSize.s60,
                  child: ElevatedButton.icon(
                    icon: const Icon(MdiIcons.checkCircle),
                    label: const Text("Checkout"),
                    onPressed: () => controller.checkOutPayment(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<PosView> createState() => PosController();
}
