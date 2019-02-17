class AppData {
  static final AppData _appData = new AppData._internal();

  String text;

  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();