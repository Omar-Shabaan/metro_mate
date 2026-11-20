import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_mate/core/localization/l10n_extension.dart';
import 'package:metro_mate/core/utils/snackbar_extension.dart';

import '../../view_model/auth_cubit.dart';
import '../../view_model/auth_state.dart';
import '../../view_model/auth_validator.dart';
import 'auth_tabs.dart';
import 'field_widget.dart';
import 'forgot_password_dialog.dart';
import 'line_strip.dart';
import 'primary_button.dart';
import 'social_buttons.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.minHeight,
    required this.isLogin,
    required this.onModeChanged,
  });

  final double minHeight;
  final bool isLogin;
  final ValueChanged<bool> onModeChanged;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
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
    final email = emailController.text.trim();
    final password = passwordController.text;
    final l10n = context.l10n;

    final error = widget.isLogin
        ? AuthValidator.login(l10n, email, password)
        : AuthValidator.signUp(l10n, email, password, confirmController.text);

    if (error != null) {
      context.showMessage(error);
      return;
    }

    final cubit = context.read<AuthCubit>();
    if (widget.isLogin) {
      cubit.signIn(email: email, password: password);
    } else {
      cubit.signUp(
        name: nameController.text.trim(),
        email: email,
        password: password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isLogin = widget.isLogin;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: widget.minHeight),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 18,
        children: [
          const LineStrip(),
          AuthTabs(isLogin: isLogin, onChanged: widget.onModeChanged),
          if (!isLogin)
            FieldWidget(label: l10n.fullName, controller: nameController),
          FieldWidget(
            label: l10n.email,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          FieldWidget(
            label: l10n.password,
            controller: passwordController,
            isPassword: true,
            hidden: hidePassword,
            onEyeTap: () => setState(() => hidePassword = !hidePassword),
          ),
          if (!isLogin)
            FieldWidget(
              label: l10n.confirmPassword,
              controller: confirmController,
              isPassword: true,
              hidden: hideConfirm,
              onEyeTap: () => setState(() => hideConfirm = !hideConfirm),
            ),
          if (isLogin)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                onTap: () => ForgotPasswordDialog.show(context),
                child: Text(
                  l10n.forgotPassword,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          BlocBuilder<AuthCubit, AuthCubitState>(
            builder: (context, state) => PrimaryButton(
              label: isLogin ? l10n.login : l10n.signup,
              loading: state is AuthLoading,
              onTap: submit,
            ),
          ),
          Center(
            child: Text(
              isLogin ? l10n.orContinueWith : l10n.termsAgree,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ),
          SocialButtons(
            onGoogle: () => context.read<AuthCubit>().googleSignIn(),
            onApple: () {},
          ),
        ],
      ),
    );
  }
}
