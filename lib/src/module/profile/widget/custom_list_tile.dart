import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    this.onPressed,
  });
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final IconData? trailingIcon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSize.s14,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: AppSize.s16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(trailingIcon),
      ),
    );
  }
}
