import 'package:flutter/material.dart';
import 'package:metro_mate/core/const/colors.dart';
import 'package:metro_mate/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.loading = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppTheme.radiusCard);

    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 50,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: radius,
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: loading ? null : onTap,
          child: Center(
            child: loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.onPrimary,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.onPrimary,
                            ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
