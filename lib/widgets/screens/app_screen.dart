import 'dart:async';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/printer_provider.dart';
import '../../providers/setting_provider.dart';
import '../../restaurant/providers/dashboard/dashboard_provider.dart';
import '../../restaurant/providers/invoice-template/invoice_template_provider.dart';
import '../../restaurant/providers/invoice/invoice_provider.dart';
import '../../restaurant/providers/report-template/report_template_provider.dart';
import '../../restaurant/providers/reports/sale_detail_report_provider.dart';
import '../../restaurant/providers/reports/sale_receipt_report_provider.dart';
import '../../restaurant/providers/reports/sale_report_provider.dart';
import '../../restaurant/providers/sale-table/sale_table_provider.dart';
import '../../restaurant/providers/sale/categories/sale_categories_provider.dart';
import '../../restaurant/providers/sale/notification_provider.dart';
import '../../restaurant/providers/sale/products/sale_products_provider.dart';
import '../../restaurant/providers/sale/sale_provider.dart';
import '../../router/app_router.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/login_form_provider.dart';
import '../../providers/my_profile_provider.dart';
import '../../providers/route_provider.dart';
import '../../providers/theme_provider.dart';
import '../../storages/connection_storage.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../../utils/theme/theme.dart';

MeteorClient meteor = MeteorClient.connect(url: '');

class AppScreen extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  const AppScreen({
    super.key,
    required this.sharedPreferences,
  });

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  late String? ipAddress;
  late AppProvider appProvider;
  late ThemeProvider themeProvider;
  late RouteProvider routeProvider;
  late AuthProvider authProvider;
  late StreamSubscription<bool> authSubscription;
  late MyProfileProvider myProfileProvider;
  late LoginFormProvider loginFormProvider;
  late SettingProvider settingProvider;
  late PrinterProvider printerProvider;
  late DashboardProvider dashboardProvider;
  late SaleCategoriesProvider saleCategoriesProvider;
  late SaleProductsProvider saleProductsProvider;
  late SaleProvider saleProvider;
  late NotificationProvider notificationProvider;
  late SaleTableProvider saleTableProvider;
  late InvoiceProvider invoiceProvider;
  late InvoiceTemplateProvider invoiceTemplateProvider;
  late ReportTemplateProvider reportTemplateProvider;
  late SaleReportProvider saleReportProvider;
  late SaleDetailReportProvider saleDetailReportProvider;
  late SaleReceiptReportProvider saleReceiptReportProvider;

  @override
  void initState() {
    appProvider = AppProvider(widget.sharedPreferences);
    themeProvider = ThemeProvider();
    routeProvider = RouteProvider();
    authProvider = AuthProvider();
    authSubscription = authProvider.onAuthStateChange.listen(onAuthStateChange);
    myProfileProvider = MyProfileProvider();
    loginFormProvider = LoginFormProvider(widget.sharedPreferences);
    settingProvider = SettingProvider();
    printerProvider = PrinterProvider();
    dashboardProvider = DashboardProvider();
    saleCategoriesProvider = SaleCategoriesProvider();
    saleProductsProvider = SaleProductsProvider();
    saleProvider = SaleProvider();
    notificationProvider = NotificationProvider();
    saleTableProvider = SaleTableProvider();
    invoiceProvider = InvoiceProvider();
    invoiceTemplateProvider = InvoiceTemplateProvider();
    reportTemplateProvider = ReportTemplateProvider();
    saleReportProvider = SaleReportProvider();
    saleDetailReportProvider = SaleDetailReportProvider();
    saleReceiptReportProvider = SaleReceiptReportProvider();
    onStartUp();
    super.initState();
  }

  void onAuthStateChange(bool login) {
    appProvider.loginState = login;
  }

  void onStartUp() async {
    ipAddress = await ConnectionStorage().getIpAddress();
    if (ipAddress != null) {
      meteor = MeteorClient.connect(url: 'http://$ipAddress');
    }
    await appProvider.onAppStart();
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // prevent device orientation changes and force portrait on mobile
    if (ResponsiveLayout.isMobile(context)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(create: (_) => appProvider),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => themeProvider),
        ChangeNotifierProvider<RouteProvider>(create: (_) => routeProvider),
        Provider<AppRouter>(create: (_) => AppRouter(appProvider)),
        ChangeNotifierProvider<AuthProvider>(create: (_) => authProvider),
        ChangeNotifierProvider<MyProfileProvider>(
            create: (_) => myProfileProvider),
        ChangeNotifierProvider<LoginFormProvider>(
            create: (_) => loginFormProvider),
        ChangeNotifierProvider<SettingProvider>(create: (_) => settingProvider),
        ChangeNotifierProvider<PrinterProvider>(create: (_) => printerProvider),
        ChangeNotifierProvider<DashboardProvider>(
            create: (_) => dashboardProvider),
        ChangeNotifierProvider<SaleCategoriesProvider>(
            create: (_) => saleCategoriesProvider),
        ChangeNotifierProvider<SaleProductsProvider>(
            create: (_) => saleProductsProvider),
        ChangeNotifierProvider<SaleProvider>(create: (_) => saleProvider),
        ChangeNotifierProvider<NotificationProvider>(
            create: (_) => notificationProvider),
        ChangeNotifierProvider<SaleTableProvider>(
            create: (_) => saleTableProvider),
        ChangeNotifierProvider<InvoiceProvider>(create: (_) => invoiceProvider),
        ChangeNotifierProvider<InvoiceTemplateProvider>(
            create: (_) => invoiceTemplateProvider),
        ChangeNotifierProvider<ReportTemplateProvider>(
            create: (_) => reportTemplateProvider),
        ChangeNotifierProvider<SaleReportProvider>(
            create: (_) => saleReportProvider),
        ChangeNotifierProvider<SaleDetailReportProvider>(
            create: (_) => saleDetailReportProvider),
        ChangeNotifierProvider<SaleReceiptReportProvider>(
            create: (_) => saleReceiptReportProvider)
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter = context.read<AppRouter>().router;
          return Consumer<ThemeProvider>(builder: (context, state, child) {
            return MaterialApp.router(
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              localizationsDelegates: [
                ...context.localizationDelegates,
                FormBuilderLocalizations.delegate,
              ],
              title: "Flutter Template",
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,
              routerConfig: goRouter,
            );
          });
        },
      ),
    );
  }
}
