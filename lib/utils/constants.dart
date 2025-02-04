import 'package:flutter/material.dart';
import '../models/select-option/select_option_model.dart';
import '../router/route_utils.dart';

class AppInfo {
  AppInfo._();
  static const String version = '1.0.0+3';
}

class AppNavigation {
  AppNavigation._();

  // routes for drawer and bottom navigation bar
  static List<SCREENS> drawer = [
    SCREENS.dashboard,
    SCREENS.reports,
    SCREENS.profile,
    SCREENS.settings,
    SCREENS.logout
  ];

  static List<SCREENS> bottomNavBar = [
    SCREENS.dashboard,
    SCREENS.reports,
    SCREENS.profile,
    SCREENS.settings,
  ];
}

class AppThemeColors {
  AppThemeColors._();
  static const MaterialColor primary = MaterialColor(0xFFFD644F, {
    50: Color.fromRGBO(253, 100, 79, .1),
    100: Color.fromRGBO(253, 100, 79, .2),
    200: Color.fromRGBO(253, 100, 79, .3),
    300: Color.fromRGBO(253, 100, 79, .4),
    400: Color.fromRGBO(253, 100, 79, .5),
    500: Color.fromRGBO(253, 100, 79, .6),
    600: Color.fromRGBO(253, 100, 79, .7),
    700: Color.fromRGBO(253, 100, 79, .8),
    800: Color.fromRGBO(253, 100, 79, .9),
    900: Color.fromRGBO(253, 100, 79, 1)
  });

  static const MaterialColor secondary = MaterialColor(0xFF303952, {
    50: Color.fromRGBO(48, 57, 82, .1),
    100: Color.fromRGBO(48, 57, 82, .2),
    200: Color.fromRGBO(48, 57, 82, .3),
    300: Color.fromRGBO(48, 57, 82, .4),
    400: Color.fromRGBO(48, 57, 82, .5),
    500: Color.fromRGBO(48, 57, 82, .6),
    600: Color.fromRGBO(48, 57, 82, .7),
    700: Color.fromRGBO(48, 57, 82, .8),
    800: Color.fromRGBO(48, 57, 82, .9),
    900: Color.fromRGBO(48, 57, 82, 1)
  });

  static const MaterialColor success = MaterialColor(0xFF00b783, {
    50: Color.fromRGBO(0, 183, 131, .1),
    100: Color.fromRGBO(0, 183, 131, .2),
    200: Color.fromRGBO(0, 183, 131, .3),
    300: Color.fromRGBO(0, 183, 131, .4),
    400: Color.fromRGBO(0, 183, 131, .5),
    500: Color.fromRGBO(0, 183, 131, .6),
    600: Color.fromRGBO(0, 183, 131, .7),
    700: Color.fromRGBO(0, 183, 131, .8),
    800: Color.fromRGBO(0, 183, 131, .9),
    900: Color.fromRGBO(0, 183, 131, 1)
  });

  static const MaterialColor failure = MaterialColor(0xFFF52F7B, {
    50: Color.fromRGBO(245, 47, 123, .1),
    100: Color.fromRGBO(245, 47, 123, .2),
    200: Color.fromRGBO(245, 47, 123, .3),
    300: Color.fromRGBO(245, 47, 123, .4),
    400: Color.fromRGBO(245, 47, 123, .5),
    500: Color.fromRGBO(245, 47, 123, .6),
    600: Color.fromRGBO(245, 47, 123, .7),
    700: Color.fromRGBO(245, 47, 123, .8),
    800: Color.fromRGBO(245, 47, 123, .9),
    900: Color.fromRGBO(245, 47, 123, 1)
  });

  static const MaterialColor warning = MaterialColor(0xFFFFC43D, {
    50: Color.fromRGBO(255, 196, 61, .1),
    100: Color.fromRGBO(255, 196, 61, .2),
    200: Color.fromRGBO(255, 196, 61, .3),
    300: Color.fromRGBO(255, 196, 61, .4),
    400: Color.fromRGBO(255, 196, 61, .5),
    500: Color.fromRGBO(255, 196, 61, .6),
    600: Color.fromRGBO(255, 196, 61, .7),
    700: Color.fromRGBO(255, 196, 61, .8),
    800: Color.fromRGBO(255, 196, 61, .9),
    900: Color.fromRGBO(255, 196, 61, 1)
  });

  static const MaterialColor info = MaterialColor(0xFF009bff, {
    50: Color.fromRGBO(0, 155, 255, .1),
    100: Color.fromRGBO(0, 155, 255, .2),
    200: Color.fromRGBO(0, 155, 255, .3),
    300: Color.fromRGBO(0, 155, 255, .4),
    400: Color.fromRGBO(0, 155, 255, .5),
    500: Color.fromRGBO(0, 155, 255, .6),
    600: Color.fromRGBO(0, 155, 255, .7),
    700: Color.fromRGBO(0, 155, 255, .8),
    800: Color.fromRGBO(0, 155, 255, .9),
    900: Color.fromRGBO(0, 155, 255, 1)
  });
}

class AppStyleDefaultProperties {
  AppStyleDefaultProperties._();

  /// r stand for radius
  static const double r = 10.0;

  /// p stand for padding
  static const double p = 12.0;

  /// bp stand for bottom padding
  static const double bp = 24.0;

  /// h stand for height
  static const double h = 12.0;

  /// w stand for width
  static const double w = 12.0;

  /// iefs stand for invoice extra font size
  static const double iefs = 6.5;
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
  // Form builder
  static const IconData search = Icons.search;
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
  static const List<String> fonts = ['MiSans Latin VF', 'MiSans Khmer VF'];
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
