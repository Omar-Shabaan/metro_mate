import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_mate/core/localization/l10n_extension.dart';
import 'package:metro_mate/core/utils/snackbar_extension.dart';

import '../view_model/auth_cubit.dart';
import '../view_model/auth_state.dart';
import 'widgets/auth_form.dart';
import 'widgets/auth_header.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void onAuthStateChanged(BuildContext context, AuthCubitState state) {
    if (state is AuthError) {
      context.showMessage(state.message);
    }
    if (state is AuthSuccess && state.needsConfirmation) {
      context.showMessage(context.l10n.accountCreated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final minTitle = isLogin ? 324.0 : 274.0;
    final formHeight = isLogin ? 485.0 : 604.0;
    final titleHeight = max(minTitle, screenHeight - formHeight);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: BlocListener<AuthCubit, AuthCubitState>(
        listener: onAuthStateChanged,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                AuthHeader(height: titleHeight, isLogin: isLogin),
                AuthForm(
                  minHeight: screenHeight - titleHeight,
                  isLogin: isLogin,
                  onModeChanged: (value) => setState(() => isLogin = value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
