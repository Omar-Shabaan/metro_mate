// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_mate/core/const/colors.dart';
import 'package:metro_mate/core/localization/l10n_extension.dart';
import 'package:metro_mate/core/utils/snackbar_extension.dart';

import '../../view_model/auth_cubit.dart';
import 'field_widget.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  static Future<void> show(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return showDialog<void>(
      context: context,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const ForgotPasswordDialog()),
    );
  }

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void send() {
    final email = controller.text.trim();
    if (email.isEmpty) {
      context.showMessage(context.l10n.enterEmail);
      return;
    }
    context.read<AuthCubit>().resetPassword(email: email);
    context.showMessage(context.l10n.resetEmailSent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.forgotPassword),
      content: FieldWidget(
        label: l10n.email,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel , style: const TextStyle(fontSize: 14),),
        ),
        TextButton(
          onPressed: send,
          child: Text(l10n.send , style: const TextStyle(fontSize: 14),),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.background,
          ),
        ),
      ],
    );
  }
}
