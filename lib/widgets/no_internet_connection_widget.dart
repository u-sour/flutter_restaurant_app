import 'package:flutter/material.dart';
import 'screens/app_screen.dart';
import '../utils/constants.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: ListTile(
        leading: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AppDefaultIcons.noInternet),
          ],
        ),
        title: const Text('Oops, Can\'t Connect To Server'),
        subtitle:
            const Text('Please, Check Your Internet Connection And Try Again'),
        trailing: TextButton(
            onPressed: () {
              meteor.reconnect();
            },
            child: const Text('Retry')),
      ),
    );
  }
}
