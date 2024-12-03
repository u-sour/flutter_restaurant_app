import 'package:flutter/material.dart';
import '../models/select-option/select_option_model.dart';
import '../router/route_utils.dart';

class AppNavigation {
  AppNavigation._();

  // screens for drawer and bottom navigation bar
  static List<SCREENS> drawer = [
    SCREENS.dashboard,
    SCREENS.formBuilder,
    SCREENS.profile,
    SCREENS.settings,
    SCREENS.logout
  ];

  static List<SCREENS> bottomNavBar = [
    SCREENS.dashboard,
    SCREENS.formBuilder,
    SCREENS.profile,
    SCREENS.settings,
  ];
}

class AppThemeColors {
  AppThemeColors._();

  static const MaterialColor primary = MaterialColor(0xFF212529, {
    50: Color.fromRGBO(33, 37, 41, .1),
    100: Color.fromRGBO(33, 37, 41, .2),
    200: Color.fromRGBO(33, 37, 41, .3),
    300: Color.fromRGBO(33, 37, 41, .4),
    400: Color.fromRGBO(33, 37, 41, .5),
    500: Color.fromRGBO(33, 37, 41, .6),
    600: Color.fromRGBO(33, 37, 41, .7),
    700: Color.fromRGBO(33, 37, 41, .8),
    800: Color.fromRGBO(33, 37, 41, .9),
    900: Color.fromRGBO(33, 37, 41, 1)
  });

  static const MaterialColor success = MaterialColor(0xFF2a9d8f, {
    50: Color.fromRGBO(42, 157, 143, .1),
    100: Color.fromRGBO(42, 157, 143, .2),
    200: Color.fromRGBO(42, 157, 143, .3),
    300: Color.fromRGBO(42, 157, 143, .4),
    400: Color.fromRGBO(42, 157, 143, .5),
    500: Color.fromRGBO(42, 157, 143, .6),
    600: Color.fromRGBO(42, 157, 143, .7),
    700: Color.fromRGBO(42, 157, 143, .8),
    800: Color.fromRGBO(42, 157, 143, .9),
    900: Color.fromRGBO(42, 157, 143, 1)
  });

  static const MaterialColor failure = MaterialColor(0xFFef476f, {
    50: Color.fromRGBO(239, 71, 111, .1),
    100: Color.fromRGBO(239, 71, 111, .2),
    200: Color.fromRGBO(239, 71, 111, .3),
    300: Color.fromRGBO(239, 71, 111, .4),
    400: Color.fromRGBO(239, 71, 111, .5),
    500: Color.fromRGBO(239, 71, 111, .6),
    600: Color.fromRGBO(239, 71, 111, .7),
    700: Color.fromRGBO(239, 71, 111, .8),
    800: Color.fromRGBO(239, 71, 111, .9),
    900: Color.fromRGBO(239, 71, 111, 1)
  });

  static const MaterialColor warning = MaterialColor(0xFFfca311, {
    50: Color.fromRGBO(252, 163, 17, .1),
    100: Color.fromRGBO(252, 163, 17, .2),
    200: Color.fromRGBO(252, 163, 17, .3),
    300: Color.fromRGBO(252, 163, 17, .4),
    400: Color.fromRGBO(252, 163, 17, .5),
    500: Color.fromRGBO(252, 163, 17, .6),
    600: Color.fromRGBO(252, 163, 17, .7),
    700: Color.fromRGBO(252, 163, 17, .8),
    800: Color.fromRGBO(252, 163, 17, .9),
    900: Color.fromRGBO(252, 163, 17, 1)
  });

  static const MaterialColor info = MaterialColor(0xFF5aa9e6, {
    50: Color.fromRGBO(90, 169, 230, .1),
    100: Color.fromRGBO(90, 169, 230, .2),
    200: Color.fromRGBO(90, 169, 230, .3),
    300: Color.fromRGBO(90, 169, 230, .4),
    400: Color.fromRGBO(90, 169, 230, .5),
    500: Color.fromRGBO(90, 169, 230, .6),
    600: Color.fromRGBO(90, 169, 230, .7),
    700: Color.fromRGBO(90, 169, 230, .8),
    800: Color.fromRGBO(90, 169, 230, .9),
    900: Color.fromRGBO(90, 169, 230, 1)
  });
}

class AppStyleDefaultProperties {
  AppStyleDefaultProperties._();

  /// r stand for radius
  static const double r = 10.0;

  /// p stand for padding
  static const double p = 16.0;

  /// bp stand for bottom padding
  static const double bp = 28.0;

  /// h stand for height
  static const double h = 16.0;

  /// w stand for width
  static const double w = 16.0;
}

class AppDefaultIcons {
  AppDefaultIcons._();
  // confirmation
  static const IconData confirmation = Icons.quiz_rounded;
  // Data
  static const IconData loading = Icons.on_device_training;
  static const IconData emptyData = Icons.storage;
  // Login
  static const IconData login = Icons.login;
  static const IconData username = Icons.face;
  static const IconData password = Icons.password;
  static const IconData showPassword = Icons.visibility;
  static const IconData hidePassword = Icons.visibility_off;
  // Navigation
  static const IconData splashScreen = Icons.scale_sharp;
  static const IconData onBoarding = Icons.web;
  static const IconData dashboard = Icons.dashboard;
  static const IconData fromBuilder = Icons.input;
  static const IconData fromBuilderDefault = Icons.article;
  static const IconData fromBuilderExtra = Icons.post_add;
  static const IconData fromBuilderValidation = Icons.rule;
  static const IconData profile = Icons.face;
  static const IconData email = Icons.email;
  static const IconData settings = Icons.settings;
  static const IconData logout = Icons.logout;
  static const IconData error = Icons.error;
  // Widgets
  static const IconData theme = Icons.palette;
  static const IconData language = Icons.translate;
  // Connection
  static const IconData noConnection = Icons.dns;
  static const IconData noInternet = Icons.language;
  static const IconData ipAddress = Icons.settings_ethernet;
  static const IconData qrCodeScanner = Icons.qr_code_scanner;
  static const IconData info = Icons.info;
  // Printer
  static const IconData btPrinter = Icons.bluetooth;
  static const IconData print = Icons.print;
  static const IconData disconnect = Icons.print_disabled;
  static const IconData printerPaperSize = Icons.description;
  static const IconData printerFontSize = Icons.format_size;
  // Themes
  static const IconData autoTheme = Icons.brightness_auto;
  static const IconData lightTheme = Icons.light_mode;
  static const IconData darkTheme = Icons.dark_mode;
  // Actions
  static const IconData edit = Icons.edit;
  static const IconData submit = Icons.done;
  // Dialog
  static const IconData close = Icons.close;
}

class AppThemes {
  AppThemes._();
  static const List<SelectOptionModel> themes = [
    SelectOptionModel(
        icon: AppDefaultIcons.lightTheme,
        label: 'screens.settings.children.theme.options.light',
        value: ThemeMode.light),
    SelectOptionModel(
        icon: AppDefaultIcons.darkTheme,
        label: 'screens.settings.children.theme.options.dark',
        value: ThemeMode.dark),
    SelectOptionModel(
        icon: AppDefaultIcons.autoTheme,
        label: 'screens.settings.children.theme.options.auto',
        value: ThemeMode.system),
  ];
}

class AppSupportedLocales {
  AppSupportedLocales._();
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('km', 'KH')
  ];
  static Locale get en => supportedLocales.first;
  static Locale get km => supportedLocales.last;
}

class AppSupportedLanguages {
  AppSupportedLanguages._();
  static final List<SelectOptionModel> supportedLanguages = [
    SelectOptionModel(
        label: 'screens.settings.children.language.options.en',
        value: AppSupportedLocales.en),
    SelectOptionModel(
        label: 'screens.settings.children.language.options.km',
        value: AppSupportedLocales.km)
  ];
}

class AppThemeFonts {
  AppThemeFonts._();
  static const List<String> fonts = ['Poppins', 'Kantumruy Pro'];
  static String get en => fonts.first;
  static String get km => fonts.last;
}

class AppBTPrinter {
  AppBTPrinter._();
  static const List<SelectOptionModel> printerOptions = [
    SelectOptionModel(
        icon: AppDefaultIcons.print,
        label: "screens.settings.form.printer.btPrinter.options.print",
        value: "printTest"),
    SelectOptionModel(
        icon: AppDefaultIcons.disconnect,
        label: 'screens.settings.form.printer.btPrinter.options.disconnect',
        value: "disconnect")
  ];
  static const List<SelectOptionModel> printerSizes = [
    SelectOptionModel(
        label: "screens.settings.form.printer.printerPaperSize.options.58",
        value: "58mm"),
    SelectOptionModel(
        label: 'screens.settings.form.printer.printerPaperSize.options.80',
        value: "80mm")
  ];
}
