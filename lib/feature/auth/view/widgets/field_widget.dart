import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.hidden = false,
    this.onEyeTap,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool hidden;
  final VoidCallback? onEyeTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 58),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                TextFormField(
                  controller: controller,
                  obscureText: isPassword && hidden,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    fillColor: theme.scaffoldBackgroundColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    labelText: label,
                    labelStyle: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                if (isPassword)
                  // استخدام PositionedDirectional لضبط المكان بناءً على لغة النظام تلقائياً
                  PositionedDirectional(
                    end: 8, // ستكون على اليسار في العربية، وعلى اليمين في الإنجليزية
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: onEyeTap,
                      child: Icon(
                        hidden
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}