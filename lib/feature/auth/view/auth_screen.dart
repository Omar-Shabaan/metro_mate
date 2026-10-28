// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        showMessage('من فضلك أدخل البريد الإلكتروني وكلمة المرور');
        return;
      }

      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
        showMessage('البريد الإلكتروني غير صالح');
        return;
      }

      if (password.length < 6) {
        showMessage('كلمة المرور يجب ألا تقل عن 6 أحرف');
        return;
      }

      cubit.signIn(email: email, password: password);
      return;
    }

    if (passwordController.text != confirmController.text) {
      showMessage('كلمتا المرور غير متطابقتين');
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

    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is AuthError) {
        showMessage(state.message);
        }
        if (state is AuthSuccess && state.needsConfirmation) {
          showMessage('تم إنشاء الحساب، تحقق من بريدك الإلكتروني لتأكيده');
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              _buildHeroImage(titleHeight + 56),
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTitleArea(titleHeight),
                    _buildWhiteContainer(screenHeight , titleHeight, isLoading),
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.darkest.withOpacity(0.2),
                  AppColors.darkest.withOpacity(0.95),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleArea(
    double height
  ) {
    return Container(
      height: height,
      alignment: Alignment.bottomRight,
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
              const Text(
                'دليل مترو القاهرة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'رحلتك تبدأ هنا',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteContainer(double screenHeight , double titleHeight, bool isLoading) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: screenHeight - titleHeight),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildColorStrip(),
          const SizedBox(height: 18),
          _buildTabs(),
          const SizedBox(height: 18),
          if (!isLogin) ...[
            FieldWidget(label: 'الاسم الكامل', controller: nameController),
            const SizedBox(height: 18),
          ],
          FieldWidget(label: 'البريد الإلكتروني', controller: emailController),
          const SizedBox(height: 18),
          FieldWidget(
            label: 'كلمة المرور',
            controller: passwordController,
            isPassword: true,
            hidden: hidePassword,
            onEyeTap: () => setState(() => hidePassword = !hidePassword),
          ),
          const SizedBox(height: 18),
          if (!isLogin) ...[
            FieldWidget(
              label: 'تأكيد كلمة المرور',
              controller: confirmController,
              isPassword: true,
              hidden: hideConfirm,
              onEyeTap: () => setState(() => hideConfirm = !hideConfirm),
            ),
            const SizedBox(height: 18),
          ],
          if (isLogin) ...[
            const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                'نسيت كلمة المرور؟',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 18),
          ],
          _buildMainButton(isLoading),
          const SizedBox(height: 18),
          Center(
            child: Text(
              isLogin
                  ? 'أو تابع باستخدام'
                  : 'بالتسجيل، أنت توافق على الشروط وسياسة الخصوصية.',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: _buildSocialButton('Google', Icons.g_mobiledata, () {
                context.read<AuthCubit>().googleSignIn();
              })),
              const SizedBox(width: 12),
              Expanded(child: _buildSocialButton('Apple', Icons.apple , (){})),
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

  Widget _buildTabs() {
    return Container(
      height: 36,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTab('تسجيل الدخول', isLogin, () {
            setState(() => isLogin = true);
          }),
          const SizedBox(width: 4),
          _buildTab('إنشاء حساب', !isLogin, () {
            setState(() => isLogin = false);
          }),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainButton(bool isLoading) {
    return GestureDetector(
      onTap: isLoading ? null : submit,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isLoading
          ? const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                const SizedBox(width: 10),
                Text(
                  isLogin ? 'تسجيل الدخول' : 'إنشاء حساب',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
      ),
    );
  }
  
  Widget _buildSocialButton(String name, IconData icon , VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: AppColors.textPrimary),
            const SizedBox(width: 6),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
