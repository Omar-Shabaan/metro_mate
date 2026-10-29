import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_mate/core/localization/app_localization.dart';
import '../../../core/const/colors.dart';
import '../view_model/auth_cubit.dart';
import '../view_model/auth_state.dart';
import 'widgets/field_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool hidePassword = true;
  bool hideConfirm = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void submit() {
    final cubit = context.read<AuthCubit>();

    if (isLogin) {
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        showMessage(context.tr('enter_email_pass'));
        return;
      }

      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
        showMessage(context.tr('invalid_email'));
        return;
      }

      if (password.length < 8) {
        showMessage(context.tr('short_password'));
        return;
      }

      cubit.signIn(email: email, password: password);
      return;
    }

    if (passwordController.text != confirmController.text) {
      showMessage(context.tr('passwords_not_match'));
      return;
    }

    cubit.signUp(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  double get heroHeight => isLogin ? 380 : 330;
  double get titleHeight => isLogin ? 324 : 274;
  String get heroImage =>
      isLogin ? 'assets/images/auth_login.jpg' : 'assets/images/auth_signup.jpg';
  
  double getTitleHeight(double screenHeight) {
    final formHeight = isLogin ? 485.0 : 604.0;
    final minTitleHeight = isLogin ? 324.0 : 274.0;
    return max(minTitleHeight, screenHeight - formHeight);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final titleHeight = getTitleHeight(screenHeight);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is AuthError) {
          showMessage(state.message);
        }
        if (state is AuthSuccess && state.needsConfirmation) {
          showMessage(context.tr('account_created'));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: Stack(
            children: [
              _buildHeroImage(titleHeight + 56),
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTitleArea(titleHeight),
                    _buildWhiteContainer(screenHeight, titleHeight, isLoading, theme, colorScheme),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroImage(double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(heroImage, fit: BoxFit.cover),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black26,
                  Colors.black87,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleArea(double height) {
    return Container(
      height: height,
      alignment: AlignmentDirectional.bottomStart,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.directions_subway_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                context.tr('metro_guide'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            context.tr('journey_starts'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteContainer(double screenHeight, double titleHeight, bool isLoading, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: screenHeight - titleHeight),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildColorStrip(),
          const SizedBox(height: 18),
          _buildTabs(theme, colorScheme),
          const SizedBox(height: 18),
          if (!isLogin) ...[
            FieldWidget(label: context.tr('full_name'), controller: nameController),
            const SizedBox(height: 18),
          ],
          FieldWidget(label: context.tr('email'), controller: emailController),
          const SizedBox(height: 18),
          FieldWidget(
            label: context.tr('password'),
            controller: passwordController,
            isPassword: true,
            hidden: hidePassword,
            onEyeTap: () => setState(() => hidePassword = !hidePassword),
          ),
          const SizedBox(height: 18),
          if (!isLogin) ...[
            FieldWidget(
              label: context.tr('confirm_password'),
              controller: confirmController,
              isPassword: true,
              hidden: hideConfirm,
              onEyeTap: () => setState(() => hideConfirm = !hideConfirm),
            ),
            const SizedBox(height: 18),
          ],
          if (isLogin) ...[
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                context.tr('forgot_password'),
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 18),
          ],
          _buildMainButton(isLoading, colorScheme),
          const SizedBox(height: 18),
          Center(
            child: Text(
              isLogin ? context.tr('or_continue_with') : context.tr('terms_agree'),
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: _buildSocialButton('Google', Icons.g_mobiledata, colorScheme, () {
                context.read<AuthCubit>().googleSignIn();
              })),
              const SizedBox(width: 12),
              Expanded(child: _buildSocialButton('Apple', Icons.apple, colorScheme, () {})),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorStrip() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: SizedBox(
        height: 4,
        child: Row(
          children: [
            Expanded(child: Container(color: AppColors.line1)),
            Expanded(child: Container(color: AppColors.line2)),
            Expanded(child: Container(color: AppColors.line3)),
            Expanded(child: Container(color: AppColors.line4)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      height: 36,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTab(context.tr('login'), isLogin, colorScheme, () {
            setState(() => isLogin = true);
          }),
          const SizedBox(width: 4),
          _buildTab(context.tr('signup'), !isLogin, colorScheme, () {
            setState(() => isLogin = false);
          }),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool selected, ColorScheme colorScheme, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainButton(bool isLoading, ColorScheme colorScheme) {
    return GestureDetector(
      onTap: isLoading ? null : submit,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: colorScheme.onPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward, color: colorScheme.onPrimary, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    isLogin ? context.tr('login') : context.tr('signup'),
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  
  Widget _buildSocialButton(String name, IconData icon, ColorScheme colorScheme, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: colorScheme.onSurface),
            const SizedBox(width: 6),
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}