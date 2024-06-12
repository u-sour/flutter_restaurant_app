import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/providers/setting_provider.dart';
import 'package:provider/provider.dart';
import '../models/widgets/screen_list_tile_widget_model.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';

class ScreenListTileWidget extends StatelessWidget {
  final ScreenListTileWidgetModel model;
  const ScreenListTileWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, state, child) => state.loading
          ? const CircularProgressIndicator()
          : ListTile(
              leading: Icon(model.icon),
              title: Text(model.title),
              onTap: model.onTap,
              trailing: Wrap(
                spacing: 16.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (model.index == "theme")
                    Consumer<ThemeProvider>(
                      builder: (context, state, child) => Text(AppThemes.themes
                          .firstWhere((theme) => theme.value == state.themeMode)
                          .label
                          .tr()),
                    ),
                  if (model.index == "language")
                    Text(AppSupportedLanguages.supportedLanguages
                        .firstWhere(
                            (language) => language.value == context.locale)
                        .label
                        .tr()),
                  if (model.index == "ipAddress")
                    Text(state.settingDoc.ipAddress),
                  if (model.index == "printerPaperSize")
                    Text(state.settingDoc.printerPaperSize),
                  if (model.index == "printerFontSize")
                    Text('${state.settingDoc.printerFontSize}'),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
    );
  }
}
