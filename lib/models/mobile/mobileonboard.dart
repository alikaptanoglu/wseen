import 'package:flutter/material.dart';
import 'package:weloggerweb/main.dart';
import 'package:weloggerweb/models/onboardwidgets.dart';
import 'package:weloggerweb/products/image.dart';
import 'package:weloggerweb/screens/screens.dart';

class MobileOnboardOne extends StatelessWidget {
  const MobileOnboardOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildOnboard(
        image: ImageEnums.mobileonboardone.assetImage,
        header: parsedJson['title1'],
        text: parsedJson['text1'],
        nextPage: const MobileOnboardTwo(),
        index: 0),
    );
  }
}

class MobileOnboardTwo extends StatelessWidget {
  const MobileOnboardTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildOnboard(
        image: ImageEnums.mobileonboardtwo.assetImage,
        header: parsedJson['title2'],
        text: parsedJson['text2'],
        nextPage: const MobileOnboardThree(),
        index: 1),
    );
  }
}

class MobileOnboardThree extends StatelessWidget {
  const MobileOnboardThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildOnboard(
        image: ImageEnums.mobileonboardthree.assetImage,
        header: parsedJson['title3'],
        text: parsedJson['text3'],
        nextPage: const PaymentPage(),
        isViewed: true,
        index: 2),
    );
  }
}
