import 'package:flutter/material.dart';

import '../../../shared/constant/app_color.dart';

Future selectedDialog(BuildContext context, {required Function()? onContinue}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Are you sure you ?',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: AppColor.grey600),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No"),
              ),
              ElevatedButton(
                onPressed: onContinue,
                child: const Text("Yes"),
              ),
            ],
          ),
        ],
      );
    },
  );
}
