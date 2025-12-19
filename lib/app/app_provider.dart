import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void toggleLocale() {
    _locale = _locale == const Locale('en') ? const Locale('vi') : const Locale('en');
    notifyListeners();
  }
}
