import 'package:flutter/material.dart';

class AppLocalizations {
  static const Map<String, Map<String, String>> _translations = {
    'ar': {
      'metro_guide': 'دليل مترو القاهرة',
      'journey_starts': 'رحلتك تبدأ هنا',
      'login': 'تسجيل الدخول',
      'signup': 'إنشاء حساب',
      'full_name': 'الاسم الكامل',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'forgot_password': 'نسيت كلمة المرور؟',
      'or_continue_with': 'أو تابع باستخدام',
      'terms_agree': 'بالتسجيل، أنت توافق على الشروط وسياسة الخصوصية.',
      'enter_email_pass': 'من فضلك أدخل البريد الإلكتروني وكلمة المرور',
      'invalid_email': 'البريد الإلكتروني غير صالح',
      'short_password': 'كلمة المرور يجب ألا تقل عن 8 أحرف',
      'passwords_not_match': 'كلمتا المرور غير متطابقتين',
      'account_created': 'تم إنشاء الحساب، تحقق من بريدك الإلكتروني لتأكيده',
      'map_screen': 'شاشة الخريطة',
      'map_content': 'محتوى شاشة الخريطة',
      'logout': 'تسجيل الخروج',
    },
    'en': {
      'metro_guide': 'Cairo Metro Guide',
      'journey_starts': 'Your journey starts here',
      'login': 'Login',
      'signup': 'Sign up',
      'full_name': 'Full Name',
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'forgot_password': 'Forgot Password?',
      'or_continue_with': 'Or continue with',
      'terms_agree': 'By signing up, you agree to our Terms and Privacy Policy.',
      'enter_email_pass': 'Please enter your email and password',
      'invalid_email': 'Invalid email format',
      'short_password': 'Password must be at least 8 characters',
      'passwords_not_match': 'Passwords do not match',
      'account_created': 'Account created, please check your email',
      'map_screen': 'Map Screen',
      'map_content': 'Map Screen Content',
      'logout': 'Logout',
    }
  };

  static String tr(BuildContext context, String key) {
    final languageCode = Localizations.localeOf(context).languageCode;
    return _translations[languageCode]?[key] ?? key;
  }
}

extension LocalizationExt on BuildContext {
  String tr(String key) => AppLocalizations.tr(this, key);
}