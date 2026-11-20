import 'package:metro_mate/l10n/app_localizations.dart';

class AuthValidator {
  AuthValidator._();

  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? login(L10n l10n, String email, String password) {
    if (email.isEmpty || password.isEmpty) return l10n.enterEmailPass;
    if (!_emailPattern.hasMatch(email)) return l10n.invalidEmail;
    if (password.length < 8) return l10n.shortPassword;
    return null;
  }

  static String? signUp(
    L10n l10n,
    String email,
    String password,
    String confirm,
  ) {
    final error = login(l10n, email, password);
    if (error != null) return error;
    return password != confirm ? l10n.passwordsNotMatch : null;
  }
}
