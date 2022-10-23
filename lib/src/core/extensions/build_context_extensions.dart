import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:weather/src/themes/colors.dart';

extension BuildContextX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppLocalizations get localization => AppLocalizations.of(this);

  void showProgressIndicator() {
    Loader.show(
      this,
      progressIndicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(AppColors.accentColor),
      ),
      overlayColor: Colors.black26,
    );
  }

  void dismissProgressIndicator() {
    Loader.hide();
  }

  Future<T?> showBottomSheet<T>({required Widget child}) async {
    showModalBottomSheet(
      context: this,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    );
    return null;
  }
}
