// AUTHENTICATION STATE
import 'package:flutter/material.dart';

class AuthenticationNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }
}
