import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

Future<T?> selectDialog<T>({
  Function()? onPressedFirst,
  Function()? onPressedSecond,
  required IconData iconFirst,
  required IconData iconSecond,
  required String titleFirst,
  required String titleSecond,
}) async {
  return showDialog(
    barrierDismissible: false,
    context: globalContext,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: AppSize.s150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: onPressedFirst,
              icon: Icon(iconFirst),
              label: Text(titleFirst),
            ),
            ElevatedButton.icon(
              onPressed: onPressedSecond,
              icon: Icon(iconSecond),
              label: Text(titleSecond),
            ),
          ],
        ),
      ),
    ),
  );
}
