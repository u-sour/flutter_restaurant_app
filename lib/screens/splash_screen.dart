import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar_widget.dart';
import '../providers/app_provider.dart';
import '../router/route_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppProvider _appProvider;

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    onInit();
    super.initState();
  }

  void onInit() async {
    await _appProvider.onAppInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: SCREENS.splash.toTitle),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text("Splash Screen"),
          ],
        ),
      ),
    );
  }
}
