import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ShadcnInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  const ShadcnInput({
    Key? key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textAlign: textAlign,
      onChanged: onChanged,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.foreground,
          ),
      cursorColor: AppTheme.primary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mutedForeground,
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppTheme.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          borderSide: BorderSide(color: AppTheme.input, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          borderSide: BorderSide(color: AppTheme.input, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          borderSide: BorderSide(color: AppTheme.primary, width: 2), // Ring effect
        ),
      ),
    );
  }
}
