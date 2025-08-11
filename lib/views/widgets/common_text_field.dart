import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  const CommonTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      enabled: enabled,
      onTap: onTap,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
      ),
    );
  }
}
