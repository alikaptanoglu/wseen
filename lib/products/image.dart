import 'package:flutter/material.dart';

enum ImageEnums {logo, desktoponboard, mobileonboardone, mobileonboardtwo, mobileonboardthree, homelogo, denemepersonicon, webbackgroundimage, geometricbackground, xd, visalogo, mastercardlogo, americanexpresslogo, discovernetworklogo, trianglebackground, learnandroidone, learnandroidtwo, learnandroidthree, learnandroidfour, back}

extension ImageEnumExtension on ImageEnums {
  String get _toPath => 'assets/images/ic_$name.png';

  Image get toImage => Image.asset(_toPath);
  AssetImage get assetImage => AssetImage(_toPath);
}
