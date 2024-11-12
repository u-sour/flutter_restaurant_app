import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../router/route_utils.dart';
import '../../providers/app_provider.dart';
import '../app_bar_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBarWidget(title: SCREENS.onBoarding.toTitle),
      body: Center(
        child: TextButton(
          onPressed: () {
            appService.onboarding = true;
          },
          child: const Text("Done"),
        ),
      ),
    );
  }
}
