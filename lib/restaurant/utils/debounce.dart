import 'dart:async';

class Debounce {
  final Duration delay;
  Timer? _timer;
  Debounce({this.delay = const Duration(milliseconds: 500)});

  void run(void Function() action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(delay, action);
  }
}
