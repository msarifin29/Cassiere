import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

Future<T?> selectImageDialog<T>({
  Function()? onPressedCamera,
  Function()? onPressedGalery,
}) async {
  return showDialog(
    context: globalContext,
    builder: (BuildContext context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
            onPressed: onPressedCamera,
            icon: const Icon(MdiIcons.camera),
            label: const Text('Camera'),
          ),
          ElevatedButton.icon(
            onPressed: onPressedGalery,
            icon: const Icon(MdiIcons.fileImage),
            label: const Text('Galery'),
          ),
        ],
      ),
    ),
  );
}
