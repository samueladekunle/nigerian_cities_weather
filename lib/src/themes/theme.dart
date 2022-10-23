import 'package:flutter/material.dart';
import 'package:weather/src/themes/colors.dart';

final textStyleWithShadow = TextStyle(color: Colors.white, shadows: [
  BoxShadow(
    color: Colors.black12.withOpacity(0.25),
    spreadRadius: 1,
    blurRadius: 4,
    offset: const Offset(0, 0.5),
  )
]);

final theme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.scaffoldBlueColor,
  cardColor: AppColors.rainBlueLight,
  textTheme: TextTheme(
    headline1: textStyleWithShadow,
    headline2: textStyleWithShadow,
    headline3: textStyleWithShadow,
    headline4: textStyleWithShadow,
    headline5: textStyleWithShadow,
    headline6: textStyleWithShadow,
    subtitle1: const TextStyle(color: Colors.white),
    bodyText2: const TextStyle(color: Colors.white),
    bodyText1: const TextStyle(color: Colors.white),
    caption: const TextStyle(color: Colors.white70, fontSize: 13),
  ),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
);
