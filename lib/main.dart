import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/app_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // remove hash (#) on web
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  // i18n
  await EasyLocalization.ensureInitialized();
  // local storage
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(EasyLocalization(
    supportedLocales: AppSupportedLocales.supportedLocales,
    path: 'assets/translations',
    fallbackLocale: AppSupportedLocales.en,
    child: AppScreen(sharedPreferences: sharedPreferences),
  ));
}
