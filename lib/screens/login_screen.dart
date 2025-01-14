import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/login_form_provider.dart';
import '../services/global_service.dart';
import '../utils/constants.dart';
import '../utils/responsive/responsive_layout.dart';
import '../widgets/connection/setup_ip_address_form_widget.dart';
import '../widgets/language/toggle_language_widget.dart';
import '../widgets/login/login_brand_widget.dart';
import '../widgets/login/login_form_widget.dart';
import '../widgets/no_internet_connection_widget.dart';
import '../widgets/toggle_switch_theme_widget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late LoginFormProvider _loginFormProvider;
  final animateDuration = const Duration(seconds: 1);

  @override
  void initState() {
    _loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);
    _loginFormProvider.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Scaffold mobileAndTabletScaffold = Scaffold(
        body: FadeIn(
      duration: animateDuration,
      child: LoginBrandWidget(
        child: SlideInLeft(
          duration: animateDuration,
          child: const Center(child: LoginFormWidget()),
        ),
      ),
    ));
    final Scaffold desktopScaffold = Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SlideInLeft(
                duration: animateDuration,
                child: const LoginFormWidget(formWidth: 1024.0)),
          ),
          Expanded(
            child: SlideInRight(
              duration: animateDuration,
              child: const LoginBrandWidget(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
            ),
          )
        ],
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            width: 120.0,
            padding: const EdgeInsets.all(8.0),
            child: const ToggleSwitchThemeWidget(),
          ),
          const SizedBox(width: 58.0, child: ToggleLanguageWidget()),
          IconButton.filled(
            onPressed: () => GlobalService.openDialog(
                contentWidget: const SetupIpAddressFormWidget(),
                context: context),
            icon: Icon(
              AppDefaultIcons.ipAddress,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobileScaffold: mobileAndTabletScaffold,
        tabletScaffold: mobileAndTabletScaffold,
        desktopScaffold: desktopScaffold,
      ),
      bottomSheet: Selector<AppProvider, bool>(
          selector: (_, state) => state.connected,
          builder: (context, connected, child) => !connected
              ? const NoInternetConnectionWidget()
              : const SizedBox.shrink()),
    );
  }
}
