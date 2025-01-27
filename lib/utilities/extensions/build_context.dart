import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension to get the localization instance
extension BuildContextX on BuildContext {
  /// Get the localization instance
  AppLocalizations get l10n => AppLocalizations.of(this);
}
