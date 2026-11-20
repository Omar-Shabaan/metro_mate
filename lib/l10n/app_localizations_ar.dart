// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class L10nAr extends L10n {
  L10nAr([String locale = 'ar']) : super(locale);

  @override
  String get metroGuide => 'دليل مترو القاهرة';

  @override
  String get journeyStarts => 'رحلتك تبدأ هنا';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get orContinueWith => 'أو تابع باستخدام';

  @override
  String get termsAgree => 'بالتسجيل، أنت توافق على الشروط وسياسة الخصوصية.';

  @override
  String get enterEmailPass => 'من فضلك أدخل البريد الإلكتروني وكلمة المرور';

  @override
  String get invalidEmail => 'البريد الإلكتروني غير صالح';

  @override
  String get shortPassword => 'كلمة المرور يجب ألا تقل عن 8 أحرف';

  @override
  String get passwordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get accountCreated =>
      'تم إنشاء الحساب، تحقق من بريدك الإلكتروني لتأكيده';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get cancel => 'إلغاء';

  @override
  String get send => 'إرسال';

  @override
  String get enterEmail => 'من فضلك أدخل بريدك الإلكتروني';

  @override
  String get resetEmailSent => 'تم إرسال رابط إعادة تعيين كلمة المرور';
}
