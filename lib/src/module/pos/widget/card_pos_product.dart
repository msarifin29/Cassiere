import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../shared/constant/app_color.dart';
import 'custom_button_quantity.dart';

class CardPosProduct extends StatelessWidget {
  const CardPosProduct({
    Key? key,
    required this.item,
    required this.incrementQuantity,
    required this.decrementQuantity,
  }) : super(key: key);

  final ProductModel item;
  final VoidCallback? incrementQuantity;
  final VoidCallback? decrementQuantity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      color: AppColor.grey200,
      child: Row(
        children: [
          Container(
            height: size.height * 0.15,
            width: size.width * 0.32,
            padding: const EdgeInsets.all(AppSize.s8),
            child: CachedNetworkImage(imageUrl: item.image),
          ),
          Container(
            width: sizeWidth * 0.65,
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Rp. ${NumberFormat.currency(locale: 'ID', symbol: "", decimalDigits: 0).format(item.price)}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      """${item.quantity.toString()} x Rp. ${NumberFormat.currency(locale: 'ID', symbol: "", decimalDigits: 0).format(item.quantity * item.price)}""",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(
                      width: size.width * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButtonQuantity(
                              icon: Icons.remove, onTap: decrementQuantity),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.quantity.toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          CustomButtonQuantity(
                              icon: Icons.add, onTap: incrementQuantity),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
