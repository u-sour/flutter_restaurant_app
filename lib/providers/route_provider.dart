import 'package:flutter/foundation.dart';

class RouteProvider extends ChangeNotifier {
  int _routeIndexState = 0;

  // getter
  int get routeIndexState => _routeIndexState;

  // setter
  set routeIndexState(int state) {
    _routeIndexState = state;
    notifyListeners();
  }

  // method
  void changeRouteIndexState(int index) => routeIndexState = index;
}
