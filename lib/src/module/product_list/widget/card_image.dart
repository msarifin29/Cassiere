import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../shared/constant/app_color.dart';
import '../../../shared/constant/app_string.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppSize.s100,
            width: AppSize.s100,
            margin: const EdgeInsets.all(AppSize.s20),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.grey300),
              image: const DecorationImage(
                image: AssetImage(AppString.imageOffline),
              ),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: Image.network(item.image!, fit: BoxFit.cover),
            ),
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
    );
  }
}
