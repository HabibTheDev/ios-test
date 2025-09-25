import 'dart:ui';

abstract class DebounceRepo {
  void debounce(VoidCallback action, {int delayMilliseconds});
  void dispose();
}
