import 'package:country_pickers/countries.dart';
import 'package:flutter/material.dart';

class ModelProvider extends ChangeNotifier {

  Uri? _paymentURL;
  Uri? get paymentURL => _paymentURL;

  setPaymentURL(Uri url){
    _paymentURL = url;
    notifyListeners();
  }


  int _indicatorIndex = 0;
  int get indicatorIndex => _indicatorIndex;

  setIndicatorIndex(int value){
    _indicatorIndex = value;
    notifyListeners();
  }

  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  DateTime get endDate => _endDate;

  setEndDate(DateTime date){
    _endDate = date;
    notifyListeners();
  }

  DateTime _startDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime get startDate => _startDate;

  setStartDate(DateTime date){
    _startDate = date;
    notifyListeners();
  }

  double _animatedFloatButtonPositionedValue = 0;
  double get animatedFloatButtonPositionedValue => _animatedFloatButtonPositionedValue;

  setAnimatedFloatButtonPositionedValue(double value){
    _animatedFloatButtonPositionedValue = value;
    notifyListeners();
  } 
  
  double _mainAnimatedTopPositionedValue = 600;
  double get mainAnimatedTopPositionedValue => _mainAnimatedTopPositionedValue;

  setMainAnimatedTopPositionedValue(double value){
    _mainAnimatedTopPositionedValue = value;
    notifyListeners();
  } 

  bool _menuAnimStatus = true;
  bool get menuAnimStatus => _menuAnimStatus;

  setMenuAnimStatus(bool value){
    _menuAnimStatus = value;
    notifyListeners();
  }

  bool _supportMailHover = false;
  bool get supportMailHover => _supportMailHover;

  setSupportMailHover(bool value){
    _supportMailHover = value;
    notifyListeners();
  }

  bool _endTermsHover = false;
  bool get endTermsHover => _endTermsHover;

  setEndTermsHover(bool value){
    _endTermsHover = value;
    notifyListeners();
  }

  bool _endPrivacyPolicyHover = false;
  bool get endPrivacyPolicyHover => _endPrivacyPolicyHover;

  setEndPrivacyPolicyHover(bool value){
    _endPrivacyPolicyHover = value;
    notifyListeners();
  }

  bool _endLastSeenHover = false;
  bool get endLastSeenHover => _endLastSeenHover;

  setEndLastSeenHover(bool value){
    _endLastSeenHover = value;
    notifyListeners();
  }

  bool _endOnlineCheckerHover = false;
  bool get endOnlineCheckerHover => _endOnlineCheckerHover;

  setEndOnlineCheckerHover(bool value){
    _endOnlineCheckerHover = value;
    notifyListeners();
  }

  bool _endFeaturesHover = false;
  bool get endFeaturesHover => _endFeaturesHover;

  setEndFeaturesHover(bool value){
    _endFeaturesHover = value;
    notifyListeners();
  }

  bool _endHomeHover = false;
  bool get endHomeHover => _endHomeHover;

  setEndHomeHover(bool value){
    _endHomeHover = value;
    notifyListeners();
  }

  double _mainScrollPixel = 0;
  double get mainScrollPixel => _mainScrollPixel;

  setMainScrollPixel(double value){
    _mainScrollPixel = value;
    notifyListeners();
  }

  bool _signHover = false;
  bool get signHover => _signHover;

  setSignHover(bool value){
    _signHover = value;
    notifyListeners();
  }

  int _activeLink = 0;
  int get activeLink => _activeLink;

  setActiveLink(int value){
    _activeLink = value;
    notifyListeners();
  }

  bool _featuresHover = false;
  bool get featuresHover => _featuresHover;

  setFeaturesHover(bool value){
    _featuresHover = value;
    notifyListeners();
  }

  bool _onlineCheckerHover = false;
  bool get onlineCheckerHover => _onlineCheckerHover;

  setOnlineCheckerHover(bool value){
    _onlineCheckerHover = value;
    notifyListeners();
  }

  bool _homeHover = false;
  bool get homeHover => _homeHover;

  setHomeHover(bool value){
    _homeHover = value;
    notifyListeners();
  }

  bool _lastSeenHover = false;
  bool get lastSeenHover => _lastSeenHover;

  setLastSeenHover(bool value){
    _lastSeenHover = value;
    notifyListeners();
  }

  dynamic _subscriptionExpDate;
  dynamic get subscriptionExpDate => _subscriptionExpDate;

  setSubscriptionExpDate(Duration value){
    _subscriptionExpDate = value;
    notifyListeners();
  }

  int _subscriptionType = 0;
  int get subscriptionType => _subscriptionType;

  setSubscriptionType(int value){
    _subscriptionType = value;
    notifyListeners();
  }

  int _androidOrIOS = 0;
  int get androidOrIOS => _androidOrIOS;

  setAndroidOrIOS(int value){
    _androidOrIOS = value;
    notifyListeners();
  }

  bool _paymentFieldIsNotEmpty = false;
  bool get paymentFieldIsNotEmpty => _paymentFieldIsNotEmpty;

  getPaymentFieldIsNotEmpty(bool value){
    _paymentFieldIsNotEmpty = value;
    notifyListeners();
  }

  String? _dialCode = '+${countryList.where((element) => element.isoCode == WidgetsBinding.instance.window.locales.first.countryCode).first.phoneCode}';
  String? get dialCode => _dialCode;

  setDialCode(String newDialCode){
    _dialCode = newDialCode;
    notifyListeners();
  }

  
  bool _rememberMe = true;
  //bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  setRememberME(bool value){
    _rememberMe = value;
    notifyListeners();
  }

  bool _isNotificationOPEN = false;
  bool get isNotificationOPEN => _isNotificationOPEN;

  toggleNotification(){
    _isNotificationOPEN = !_isNotificationOPEN;
    notifyListeners();
  }

  setNotification(bool value){
    _isNotificationOPEN = value;
    notifyListeners();
  }

  String _securityCode = '';
  String get securityCode => _securityCode;

  getSecurityCode(String text){
    _securityCode = text;
    notifyListeners();
  }

  String _expirationDate = '';
  String get expirationDate => _expirationDate;

  getExpirationDate(String text){
    _expirationDate = text;
    notifyListeners();
  }

  String _cardNumber = '';
  String get cardNumber => _cardNumber;

  getCardNumber(String value){
    _cardNumber = value;
    notifyListeners();
  }

  String _cardHolderName = 'Card Holder Name';
  String get cardHolderName => _cardHolderName;

  getCardHolderName(String text){
    _cardHolderName = text;
    notifyListeners();
  }

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  setPaymentIndex(int index){
    _paymentIndex = index;
    notifyListeners();
  }

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

  setMenu(bool value) {
    _isMenuOpen = value;
    notifyListeners();
  }
}
