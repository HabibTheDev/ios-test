import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../repository/local/debounce_repo.dart';

class DebounceService implements DebounceRepo {
  Timer? _timer;

  @override
  void debounce(VoidCallback action, {int delayMilliseconds = 600}) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delayMilliseconds), action);
  }

  @override
  void dispose() {
    _timer?.cancel();
    debugPrint('debounce timer disposed');
  }
}
