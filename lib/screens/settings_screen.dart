import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/services/connection_service.dart';
import 'package:flutter_template/services/settings_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/select-option/select_option_model.dart';
import '../models/widgets/screen_list_tile_widget_model.dart';
import '../providers/setting_provider.dart';
import '../router/route_utils.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';
import '../utils/responsive/responsive_layout.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/screen_list_tile_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingProvider _readProvider;

  @override
  void initState() {
    super.initState();
    _readProvider = context.read<SettingProvider>();
    _readProvider.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider readThemeProvider = context.read<ThemeProvider>();
    const String prefixTitle = "screens.settings.children";
    const String prefixSettingForm = "screens.settings.form";
    List<ScreenListTileWidgetModel> models = [
      ScreenListTileWidgetModel(
        index: 'theme',
        icon: AppDefaultIcons.theme,
        title: '$prefixTitle.theme.title'.tr(),
        onTap: () {
          const themes = AppThemes.themes;
          _showSettingsModalBottomSheet(
            context: context,
            items: themes,
            currentValue: readThemeProvider.themeMode,
            onChanged: (value) {
              final ThemeMode themeMode = value;
              readThemeProvider.switchTheme(themeMode);
              context.pop();
            },
          );
        },
      ),
      ScreenListTileWidgetModel(
        index: 'language',
        icon: AppDefaultIcons.language,
        title: '$prefixTitle.language.title'.tr(),
        onTap: () {
          final supportedLanguages = AppSupportedLanguages.supportedLanguages;
          _showSettingsModalBottomSheet(
              context: context,
              currentValue: context.locale,
              items: supportedLanguages,
              onChanged: (value) async {
                final Locale language = value;
                await context
                    .setLocale(language)
                    .then((value) => context.pop());
              });
        },
      ),
      ScreenListTileWidgetModel(
        index: 'ipAddress',
        icon: AppDefaultIcons.ipAddress,
        title: '$prefixSettingForm.ipAddress.title'.tr(),
        onTap: () => ConnectionService.showSetupIpAddressDialog(context),
      ),
      ScreenListTileWidgetModel(
        index: 'btPrinter',
        icon: AppDefaultIcons.printer,
        title: '$prefixSettingForm.printer.btPrinter.title'.tr(),
        onTap: () {},
      ),
      ScreenListTileWidgetModel(
        index: 'printerPaperSize',
        icon: AppDefaultIcons.printerPaperSize,
        title: '$prefixSettingForm.printer.printerPaperSize.title'.tr(),
        onTap: () async {
          const printerPaperSizes = AppBTPrinterPaperSize.printerSizes;
          _showSettingsModalBottomSheet(
              context: context,
              currentValue: _readProvider.settingDoc.printerPaperSize,
              items: printerPaperSizes,
              onChanged: (value) {
                final String paperSize = value;
                _readProvider.setPrinterPaperSize(paperSize: paperSize);
                context.pop();
              });
        },
      ),
      ScreenListTileWidgetModel(
        index: 'printerFontSize',
        icon: AppDefaultIcons.printerFontSize,
        title: '$prefixSettingForm.printer.printerFontSize.title'.tr(),
        onTap: () => SettingsService.showChangePrinterFontSizeDialog(context),
      ),
    ];
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) {
        //clear search field focus
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(title: SCREENS.settings.toTitle),
        drawer:
            !ResponsiveLayout.isDesktop(context) ? const DrawerWidget() : null,
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) {
                final model = models[index];
                return ScreenListTileWidget(model: model);
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<dynamic> _showSettingsModalBottomSheet(
      {required BuildContext context,
      required dynamic currentValue,
      required List<SelectOptionModel> items,
      void Function(dynamic)? onChanged}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return RadioListTile(
              title: Text(item.label.tr()),
              value: item.value,
              groupValue: currentValue,
              onChanged: onChanged,
            );
          },
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppStyleDefaultProperties.r),
        ),
      ),
    );
  }
}
