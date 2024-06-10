import 'package:flutter/material.dart';
import 'package:flutter_template/storages/connection_storage.dart';
import '../models/setting/setting_model.dart';

class SettingProvider extends ChangeNotifier {
  late SettingModel _settingDoc;
  bool _loading = false;

  // getter
  SettingModel get settingDoc => _settingDoc;
  bool get loading => _loading;

  void initState() async {
    _loading = true;
    String ipAddress = await ConnectionStorage().getIpAddress() ?? '';
    _settingDoc = SettingModel(ipAddress: ipAddress);
    _loading = false;
    notifyListeners();
  }
}
