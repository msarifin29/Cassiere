import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

import '../../../shared/constant/app_color.dart';

class CustomQRCodeWidget extends StatelessWidget {
  const CustomQRCodeWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      margin: const EdgeInsets.symmetric(
          horizontal: AppSize.s16, vertical: AppSize.s12),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.qr_code_2_outlined,
                  size: AppSize.s60,
                  color: AppColor.blackColor,
                ),
                Text(
                  "Scan QRCode",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColor.lightBlueColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
