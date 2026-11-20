// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get metroGuide => 'Cairo Metro Guide';

  @override
  String get journeyStarts => 'Your journey starts here';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign up';

  @override
  String get fullName => 'Full name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get termsAgree =>
      'By signing up, you agree to our Terms and Privacy Policy.';

  @override
  String get enterEmailPass => 'Please enter your email and password';

  @override
  String get invalidEmail => 'Invalid email format';

  @override
  String get shortPassword => 'Password must be at least 8 characters';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get accountCreated => 'Account created, please check your email';

  @override
  String get logout => 'Logout';

  @override
  String get cancel => 'Cancel';

  @override
  String get send => 'Send';

  @override
  String get enterEmail => 'Please enter your email';

  @override
  String get resetEmailSent => 'Password reset email sent';
}
