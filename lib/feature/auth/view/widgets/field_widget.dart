import 'package:flutter/material.dart';

import '../../../../core/const/colors.dart';

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
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColors.background,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    labelText: label,
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                if (isPassword)
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: onEyeTap,
                      child: Icon(
                        hidden
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
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
