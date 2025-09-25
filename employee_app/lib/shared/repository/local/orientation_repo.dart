abstract class OrientationRepo {
  void hideStatusBar();
  void showStatusBar();
  Future<void> landscapeOrientation();
  Future<void> portraitOrientation();
}
