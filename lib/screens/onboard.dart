import 'package:flutter/material.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/screens/home.dart';
import 'package:weloggerweb/services/services.dart';

class OnboardPages extends StatefulWidget {
  const OnboardPages({Key? key}) : super(key: key);

  @override
  State<OnboardPages> createState() => _OnboardPagesState();
}

class _OnboardPagesState extends State<OnboardPages> {

  bool? isViewed;

  @override
  void initState() {
    getView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return getPage();
  }

  Future<void> getView() async {
    String? value = CookieManager.getCookie('isviewed');
    isViewed = value == null ? false : true;
    setState(() {
      
    });
  }

  getPage(){
    if(isViewed == null){
      return const Loading();
    }
    if(isViewed!){
      return const MobileOnboardOne();
    }
    if(!isViewed!){
      return const HomePage();
    }
  }
}


