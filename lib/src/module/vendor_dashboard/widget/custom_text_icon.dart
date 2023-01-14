import 'package:cassiere/core.dart';
import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextIcon extends StatelessWidget {
  const CustomTextIcon({
    Key? key,
    this.onTap,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: AppColor.cardColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: AppSize.s100,
                color: AppColor.whiteColor,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.whiteColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
