import 'package:flutter/material.dart';

class ModelProvider extends ChangeNotifier {

  double _flagPosition = 0.0;
  double get flagPosition => _flagPosition;

  getFlagPosition(double position){
    _flagPosition = position;
    notifyListeners();
  }

  double _flagHeight = 0.0;
  double get flagHeight => _flagHeight;

  set80FlagHeight(){
    _flagHeight = 80.0;
    notifyListeners();
  }

  set0FlagHeight(){
    _flagHeight = 0.0;
    notifyListeners();
  }

  int _signState = 0;
  int get signState => _signState;

  toggleSignState() {
    _signState == 1 ? _signState = 0 : _signState = 1;
    notifyListeners();
  }

  setSignState(int value){
    _signState = value;
    notifyListeners();
  }

  bool _isMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen;

  toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }
}
