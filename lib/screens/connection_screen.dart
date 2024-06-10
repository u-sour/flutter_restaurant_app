import 'package:flutter/material.dart';
import '../widgets/connection/connection_form_widget.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ConnectionFormWidget(),
    );
  }
}
