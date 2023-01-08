import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

import '../../../shared/constant/app_color.dart';

class CustomButtonQuantity extends StatelessWidget {
  const CustomButtonQuantity({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.s24,
        width: AppSize.s24,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1.0,
              color: AppColor.blackColor,
              strokeAlign: StrokeAlign.center),
          borderRadius: BorderRadius.circular(AppSize.s6),
        ),
        alignment: Alignment.topLeft,
        child: Icon(
          icon,
          size: AppSize.s24,
        ),
      ),
    );
  }
}
