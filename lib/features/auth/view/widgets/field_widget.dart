import 'package:flutter/material.dart';
import 'package:metro_mate/core/theme/app_theme.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.hidden = false,
    this.onEyeTap,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool hidden;
  final VoidCallback? onEyeTap;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      borderSide: BorderSide.none,
    );

    return TextFormField(
      controller: controller,
      obscureText: isPassword && hidden,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        fillColor: theme.scaffoldBackgroundColor,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onEyeTap,
                iconSize: 18,
                icon: Icon(
                  hidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
      ),
    );
  }
}
