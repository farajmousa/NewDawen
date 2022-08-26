import 'dart:async';
import 'dart:convert';
import 'package:sky_vacation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_constant.dart';

class Trans {
  final Locale? locale;
  Map<String, String>? _localizedStrings;

  Trans(this.locale);

  static Trans of(BuildContext context) {
    return Localizations.of<Trans>(context, Trans)!;
  }

  String t(String key) {
    return _localizedStrings?[key] ?? "";
  }

  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('assets/lang/${locale?.languageCode ?? "en"}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  static const LocalizationsDelegate<Trans> delegate =
  _AppLocalizationsDelegate();
}


class _AppLocalizationsDelegate
    extends LocalizationsDelegate<Trans> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<Trans> load(Locale locale) async {
    Trans localizations = new Trans(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
