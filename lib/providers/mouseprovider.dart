import 'package:flutter/material.dart';

class MouseProvider extends ChangeNotifier {
  late bool _loginHover = false;
  bool get loginHover => _loginHover;

  late bool _signUpHover = false;
  bool get signUpHover => _loginHover;

  late bool _doesntHaveAccount = false;
  bool get doesntHaveAccount => _doesntHaveAccount;

  late bool _resetHover = false;
  bool get resetHover => _resetHover;

  toggleResetHover() {
    _resetHover = !_resetHover;
    notifyListeners();
  }

  toggleDoestHaveAccount() {
    _doesntHaveAccount = !_doesntHaveAccount;
    notifyListeners();
  }

  toggleSignUpHover() {
    _signUpHover = !_signUpHover;
    notifyListeners();
  }

  toggleLoginHover() {
    _loginHover = !_loginHover;
    notifyListeners();
  }
}
