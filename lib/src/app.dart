import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/core/extensions/build_context_extensions.dart';
import 'package:weather/src/routes/routes.dart';
import 'package:weather/src/themes/theme.dart';

class WeatherApp extends ConsumerWidget {
  const WeatherApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: ref.watch(goRouterProvider),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      onGenerateTitle: (BuildContext context) => context.localization.appTitle,
    );
  }
}
