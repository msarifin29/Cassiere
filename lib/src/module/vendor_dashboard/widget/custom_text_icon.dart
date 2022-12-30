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
        child: Column(
          children: [
            Icon(
              icon,
              size: 40.0,
              color: AppColor.lightBlueColor,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: AppColor.lightBlueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
