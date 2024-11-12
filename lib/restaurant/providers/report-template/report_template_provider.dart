import 'package:dart_date/dart_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../models/option/option_model.dart';
import '../../utils/constants.dart';

class ReportTemplateProvider extends ChangeNotifier {
  final String _prefixRTLayouts = 'screens.reportTemplate.layouts';
  String get prefixRTLayouts => _prefixRTLayouts;
  final String _prefixRTActions = 'screens.reportTemplate.actions';
  String get prefixRTActions => _prefixRTActions;
  List<OptionModel> _defaultRTLayouts = [];
  List<OptionModel> get defaultRTLayouts => _defaultRTLayouts;
  late final List<OptionModel> _defaultRTActions = [
    OptionModel(
        icon: RestaurantDefaultIcons.print,
        label: '$_prefixRTActions.print',
        value: 'print')
  ];
  List<OptionModel> get defaultRTActions => _defaultRTActions;
  String _reportPeriod = '';
  String get reportPeriod => _reportPeriod;
  late final List<String> _reportSignature = [
    '$_prefixRTLayouts.children.signature.children.approved',
    '$_prefixRTLayouts.children.signature.children.verified',
    '$_prefixRTLayouts.children.signature.children.prepared',
  ];
  List<String> get reportSignature => _reportSignature;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isFiltering = false;
  bool get isFiltering => _isFiltering;

  void initData() {
    _defaultRTLayouts = [
      OptionModel(label: '$_prefixRTLayouts.children.header', value: true),
      OptionModel(label: '$_prefixRTLayouts.children.filter', value: true),
      OptionModel(label: '$_prefixRTLayouts.children.content', value: true),
      OptionModel(
          label: '$_prefixRTLayouts.children.timestamp.title', value: true),
      OptionModel(label: '$_prefixRTLayouts.children.footer', value: false),
      OptionModel(
          label: '$_prefixRTLayouts.children.signature.title', value: false),
    ];
    _reportPeriod =
        '${formatDateReportPeriod(dateTime: DateTime.now().startOfDay)} - ${formatDateReportPeriod(dateTime: DateTime.now().endOfDay)}';
  }

  void toggleShowLayout({required int index, required bool? value}) {
    _defaultRTLayouts[index].value = value;
    notifyListeners();
  }

  void setReportPeriod({required DateTimeRange reportPeriodDateRange}) {
    _reportPeriod =
        '${formatDateReportPeriod(dateTime: reportPeriodDateRange.start)} - ${formatDateReportPeriod(dateTime: reportPeriodDateRange.end)}';
    notifyListeners();
  }

  String formatDateReportPeriod(
          {required DateTime dateTime,
          String formatStyle = 'dd/MM/yyyy HH:mm'}) =>
      DateFormat(formatStyle).format(dateTime);

  String formatDateReportTimestamp(
          {required DateTime dateTime,
          String formatStyle = 'dd/MM/yyyy HH:mm:ss'}) =>
      DateFormat(formatStyle).format(dateTime);

  void setIsLoading({required bool isLoading}) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setIsFiltering({required bool isFiltering}) {
    _isFiltering = isFiltering;
    notifyListeners();
  }
}
