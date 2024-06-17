import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class LoginBrandWidget extends StatelessWidget {
  final Widget? child;
  const LoginBrandWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          "https://images.unsplash.com/photo-1493934558415-9d19f0b2b4d2?q=80&w=3854&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      imageBuilder: (context, imageProvider) => Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: child),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
