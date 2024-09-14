import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../restaurant/models/user/user_model.dart';
import '../restaurant/screens/invoice_screen.dart';
import 'route_utils.dart';
import '../restaurant/screens/sale_table_screen.dart';
import '../screens/connection_screen.dart';
import '../storages/connection_storage.dart';
import '../providers/app_provider.dart';
import '../screens/error_screen.dart';
import '../screens/main_wrapper_screen.dart';
import '../screens/dashboard_screen.dart';
import '../restaurant/screens/sale_screen.dart';
import '../screens/form-builder/form_builder_screen.dart';
import '../screens/form-builder/children/form_builder_default_screen.dart';
import '../screens/form-builder/children/form_builder_validation_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/children/my_profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/printer/printer_screen.dart';
import '../widgets/printer/invoice.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/splash_screen.dart';

class AppRouter {
  late final AppProvider appProvider;
  GoRouter get router => _goRouter;

  AppRouter(this.appProvider);

  // Private Navigators Keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _rootNavigatorFormBuilder =
      GlobalKey<NavigatorState>(debugLabel: 'shellFormBuilder');
  static final _rootNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final _rootNavigatorSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appProvider,
    initialLocation: SCREENS.dashboard.toPath,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      // Main Wrapper Route
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainWrapperScreen(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            // Dashboard
            StatefulShellBranch(navigatorKey: _rootNavigatorHome, routes: [
              GoRoute(
                path: SCREENS.dashboard.toPath,
                name: SCREENS.dashboard.toName,
                builder: (context, state) => const DashboardScreen(),
              ),
            ]),
            // Form Builder
            StatefulShellBranch(
                navigatorKey: _rootNavigatorFormBuilder,
                routes: [
                  GoRoute(
                      path: SCREENS.formBuilder.toPath,
                      name: SCREENS.formBuilder.toName,
                      builder: (context, state) => const FormBuilderScreen(),
                      routes: [
                        GoRoute(
                          path: SCREENS.formBuilderDefault.toPath,
                          name: SCREENS.formBuilderDefault.toName,
                          builder: (context, state) =>
                              FormBuilderDefaultScreen(key: state.pageKey),
                        ),
                        GoRoute(
                          path: SCREENS.formBuilderValidation.toPath,
                          name: SCREENS.formBuilderValidation.toName,
                          builder: (context, state) =>
                              FormBuilderValidationScreen(key: state.pageKey),
                        ),
                      ]),
                ]),
            // Profile
            StatefulShellBranch(navigatorKey: _rootNavigatorProfile, routes: [
              GoRoute(
                  path: SCREENS.profile.toPath,
                  name: SCREENS.profile.toName,
                  builder: (context, state) => const ProfileScreen(),
                  routes: [
                    GoRoute(
                      path: SCREENS.myProfile.toPath,
                      name: SCREENS.myProfile.toName,
                      builder: (context, state) =>
                          Selector<AppProvider, UserModel?>(
                              selector: (context, state) => state.currentUser,
                              builder: (context, currentUser, child) =>
                                  MyProfileScreen(
                                    key: state.pageKey,
                                    fullName: currentUser?.profile.fullName,
                                    username: currentUser?.username,
                                    email: currentUser?.emails.first.address,
                                  )),
                    ),
                  ]),
            ]),
            // Settings
            StatefulShellBranch(navigatorKey: _rootNavigatorSettings, routes: [
              GoRoute(
                path: SCREENS.settings.toPath,
                name: SCREENS.settings.toName,
                builder: (context, state) => const SettingsScreen(),
              ),
            ]),
          ]),
      GoRoute(
        path: SCREENS.splash.toPath,
        name: SCREENS.splash.toName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: SCREENS.login.toPath,
        name: SCREENS.login.toName,
        builder: (context, state) => const LogInScreen(),
      ),
      GoRoute(
        path: SCREENS.onBoarding.toPath,
        name: SCREENS.onBoarding.toName,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: SCREENS.connection.toPath,
        name: SCREENS.connection.toName,
        builder: (context, state) => const ConnectionScreen(),
      ),
      GoRoute(
        path: SCREENS.printer.toPath,
        name: SCREENS.printer.toName,
        builder: (context, state) => const PrinterScreen(
          child: Invoice(),
        ),
      ),
      GoRoute(
        path: SCREENS.saleTable.toPath,
        name: SCREENS.saleTable.toName,
        builder: (context, state) => const SaleTableScreen(),
      ),
      GoRoute(
        path: SCREENS.sale.toPath,
        name: SCREENS.sale.toName,
        builder: (context, state) => SaleScreen(
          // Note: same route and refresh that route
          key: UniqueKey(),
        ),
      ),
      GoRoute(
        path: SCREENS.invoice.toPath,
        name: SCREENS.invoice.toName,
        builder: (context, state) {
          Map<String, dynamic> queryRouter = state.uri.queryParameters;
          final String invoiceId = queryRouter['invoiceId'];
          final bool receiptPrint = queryRouter['receiptPrint'] != null &&
              queryRouter['receiptPrint']! == 'true';
          return InvoiceScreen(
              invoiceId: invoiceId, receiptPrint: receiptPrint);
        },
      ),
      GoRoute(
        path: SCREENS.error.toPath,
        name: SCREENS.error.toName,
        builder: (context, state) => ErrorScreen(error: state.extra.toString()),
      ),
    ],
    errorBuilder: (context, state) =>
        ErrorScreen(error: state.error.toString()),
    redirect: (context, state) async {
      final loginLocation = state.namedLocation(SCREENS.login.toName);
      final dashboardLocation = state.namedLocation(SCREENS.dashboard.toName);
      final splashLocation = state.namedLocation(SCREENS.splash.toName);
      final onboardLocation = state.namedLocation(SCREENS.onBoarding.toName);
      final connectionLocation = state.namedLocation(SCREENS.connection.toName);

      final isConnected = appProvider.connected;
      final isLogedIn = appProvider.loginState;
      final isInitialized = appProvider.initialized;
      final isOnboarded = appProvider.onboarding;
      String? ipAddress = await ConnectionStorage().getIpAddress();

      final isGoingToLogin = state.matchedLocation == loginLocation;
      final isGoingToInit = state.matchedLocation == splashLocation;
      final isGoingToOnboard = state.matchedLocation == onboardLocation;
      final isGoingToConnection = state.matchedLocation == connectionLocation;

      // If not Initialized and not going to Initialized redirect to Splash
      if (!isInitialized && !isGoingToInit) {
        return splashLocation;
      } else if (isInitialized && !isConnected && ipAddress == null) {
        return connectionLocation;
        // If not onboard and not going to onboard redirect to OnBoarding
      } else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
        return onboardLocation;
        // If not logedin and not going to login redirect to Login
      } else if (isInitialized &&
          isOnboarded &&
          !isLogedIn &&
          !isGoingToLogin) {
        return loginLocation;
        // If all the scenarios are cleared but still going to any of that screen redirect to Dashboard
      } else if ((isLogedIn && isGoingToLogin) ||
          (isInitialized && isGoingToInit) ||
          (isOnboarded && isGoingToOnboard) ||
          (isConnected && isGoingToConnection)) {
        return dashboardLocation;
      } else {
        // Else Don't do anything
        return null;
      }
    },
  );
}
