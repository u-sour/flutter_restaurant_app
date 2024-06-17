import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/constants.dart';

class ToggleLanguageWidget extends StatelessWidget {
  const ToggleLanguageWidget({super.key});
  final prefixLanguageAsset = "assets/images/languages";
  @override
  Widget build(BuildContext context) {
    String languageCode = context.locale.languageCode;
    return IconButton(
        onPressed: () async {
          await context.setLocale(languageCode == "en"
              ? AppSupportedLocales.km
              : AppSupportedLocales.en);
        },
        icon: SvgPicture.asset(languageCode == "en"
            ? '$prefixLanguageAsset/en.svg'
            : '$prefixLanguageAsset/km.svg'));
  }
}
