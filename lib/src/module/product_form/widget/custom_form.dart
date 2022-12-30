import 'package:cassiere/core.dart';
import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    Key? key,
    this.validator,
    required this.onChanged,
    required this.textHelper,
    this.inputType = TextInputType.text,
    this.maxLength = 20,
    this.maxLines = 1,
    this.value,
    this.textControll,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final String textHelper;
  final TextInputType? inputType;
  final int? maxLength;
  final int? maxLines;
  final String? value;
  final TextEditingController? textControll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSize.s12, bottom: AppSize.s6),
          child: Text(
            textHelper,
            style:
                TextStyle(fontWeight: FontWeight.w500, color: AppColor.grey500),
          ),
        ),
        TextFormField(
          initialValue: value,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
          ),
          keyboardType: inputType,
          maxLength: maxLength,
          maxLines: maxLines,
          onChanged: (value) {
            onChanged(value);
          },
        )
      ],
    );
  }
}
