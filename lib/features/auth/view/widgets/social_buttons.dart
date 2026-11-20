import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key, required this.onGoogle, required this.onApple});

  final VoidCallback onGoogle;
  final VoidCallback onApple;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: _SocialButton(
            label: 'Google',
            icon: Icons.g_mobiledata,
            onTap: onGoogle,
          ),
        ),
        Expanded(
          child: _SocialButton(
            label: 'Apple',
            icon: Icons.apple,
            onTap: onApple,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(minimumSize: const Size(0, 40)),
      icon: Icon(icon, size: 22),
      label: Text(label),
    );
  }
}
