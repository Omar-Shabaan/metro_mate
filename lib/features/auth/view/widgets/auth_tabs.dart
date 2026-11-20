import 'package:flutter/material.dart';
import 'package:metro_mate/core/localization/l10n_extension.dart';

class AuthTabs extends StatelessWidget {
  const AuthTabs({super.key, required this.isLogin, required this.onChanged});

  final bool isLogin;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      height: 36,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 4,
        children: [
          _Tab(
            label: l10n.login,
            selected: isLogin,
            onTap: () => onChanged(true),
          ),
          _Tab(
            label: l10n.signup,
            selected: !isLogin,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tabTheme = theme.tabBarTheme;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? theme.colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: selected
                  ? tabTheme.labelColor
                  : tabTheme.unselectedLabelColor,
            ),
          ),
        ),
      ),
    );
  }
}
