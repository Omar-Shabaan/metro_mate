import 'package:flutter/material.dart';
import 'package:metro_mate/core/const/colors.dart';
import 'package:metro_mate/core/localization/l10n_extension.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.height, required this.isLogin});

  final double height;
  final bool isLogin;

  static const double overlap = 56;
  static const String loginImage = 'assets/images/auth_login.jpg';
  static const String signupImage = 'assets/images/auth_signup.jpg';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: -overlap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    isLogin ? loginImage : signupImage,
                    key: ValueKey(isLogin),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(gradient: AppColors.imageOverlay),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            start: 24,
            end: 24,
            bottom: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.whiteTint,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.directions_subway_outlined,
                        color: AppColors.textOnDark,
                        size: 22,
                      ),
                    ),
                    Text(
                      l10n.metroGuide,
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.textOnDark,
                      ),
                    ),
                  ],
                ),
                Text(
                  l10n.journeyStarts,
                  style: textTheme.displayMedium?.copyWith(
                    color: AppColors.textOnDark,
                    fontSize: 32,
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
