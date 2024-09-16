import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  Future<void> filter({int tab = 0}) async {
    _selectedTab = tab;
    notifyListeners();
  }
}
