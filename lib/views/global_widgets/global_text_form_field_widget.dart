import 'package:flutter/material.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';

class GlobalTextFormFieldWidget extends StatelessWidget {
  final bool? obsecureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onPressedSuffixIcon;
  final int? maxLines;

  const GlobalTextFormFieldWidget({
    super.key,
    this.obsecureText,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    required this.keyboardType,
    this.onChanged,
    this.onPressedSuffixIcon,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText ?? false,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: keyboardType == TextInputType.multiline
          ? TextInputAction.newline
          : TextInputAction.done,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyleConstant.bodyMedium,
        hintText: hintText,
        hintStyle: TextStyleConstant.bodyMedium,
        errorText: errorText,
        errorStyle: TextStyleConstant.captionMedium,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconColor: ColorConstant.black,
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorConstant.primaryHover,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorConstant.primary,
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorConstant.error,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorConstant.errorFocused,
            width: 0.5,
          ),
        ),
      ),
      onChanged: onChanged,
      onTap: onPressedSuffixIcon,
    );
  }
}
