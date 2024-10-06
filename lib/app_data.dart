// ignore_for_file: prefer_conditional_assignment, avoid_print

class AppData {
  static AppData? appData;

  final String userId = '123';

  // Make the Private Constructor:
  AppData._internal() {
    print("APP DATA CAlled");
  }

  // Getter method to get it:
  static get instance {
    if (appData == null) {
      appData = AppData._internal();
    }
    return appData!;
  }
}
