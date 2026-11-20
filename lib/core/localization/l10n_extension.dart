import 'package:flutter/widgets.dart';
import 'package:metro_mate/l10n/app_localizations.dart';

export 'package:metro_mate/l10n/app_localizations.dart';

extension L10nExtension on BuildContext {
  L10n get l10n => L10n.of(this);
}
