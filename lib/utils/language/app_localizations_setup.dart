import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:valetparking_user/utils/language/app_localizations.dart';

class AppLocalizationsSetup {
  static const Iterable<Locale> supportedLocale = [
    Locale('en'),
    Locale('ar'),
  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static Locale? localeResolutionCallback(List<Locale>? locales, Iterable<Locale> supportedLocales) {
    if (locales == null || locales.isEmpty) {
      return supportedLocales.first;
    }

    final Locale locale = locales.first;

    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      } else if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}