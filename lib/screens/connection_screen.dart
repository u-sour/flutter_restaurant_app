import 'package:flutter/material.dart';
import '../widgets/connection/connection_form_widget.dart';
import '../widgets/language/toggle_language_widget.dart';
import '../widgets/toggle_switch_theme_widget.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
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
          const SizedBox(width: 48.0, child: ToggleLanguageWidget()),
        ],
      ),
      body: const ConnectionFormWidget(),
    );
  }
}
