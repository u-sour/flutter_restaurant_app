import 'dart:ui';
import 'package:flutter/material.dart';

class LoginBrandWidget extends StatelessWidget {
  final Widget? child;
  const LoginBrandWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaY: 2.0,
                sigmaX: 2.0), //SigmaX and Y are just for X and Y directions
            child: Image.asset('assets/images/login/bg.jpg',
                fit: BoxFit
                    .cover), //here you can use any widget you'd like to blur .
          ),
        ),
        child!
      ],
    );
  }
}
