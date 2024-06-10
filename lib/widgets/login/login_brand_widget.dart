import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class LoginBrandWidget extends StatelessWidget {
  final Widget? child;
  const LoginBrandWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1493934558415-9d19f0b2b4d2?q=80&w=3854&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            fit: BoxFit.cover,
          ),
        ),
        child: child);
  }
}
