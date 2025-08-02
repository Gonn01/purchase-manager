import 'package:flutter/widgets.dart';
import 'package:purchase_manager/l10n/arb/app_localizations.dart';

/// Extension to get the localization instance
extension BuildContextX on BuildContext {
  /// Get the localization instance
  AppLocalizations get l10n => AppLocalizations.of(this);
}
