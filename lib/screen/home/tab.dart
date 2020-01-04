abstract class Tab {
  static const double PADDING = 15.0;
  /// Called on the tab when it is refreshed
  Future<void> onRefresh();
}
