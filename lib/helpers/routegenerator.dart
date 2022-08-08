import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wseen/models/homepage.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/screens/failed.dart';
import 'package:wseen/screens/lastseen.dart';
import 'package:wseen/screens/main.dart';
import 'package:wseen/screens/onlinechecker.dart';
import 'package:wseen/screens/privacypolicy.dart';
import 'package:wseen/screens/screens.dart';
import 'package:wseen/screens/success.dart';
import 'package:wseen/screens/termsofservice.dart';

class RouteGenerator{

  static String initialRoute = '/';

  static Route? generateRoute(RouteSettings settings){
    const String homeRoute = '/';
    const String onlineChecker = '/online-checker';
    const String lastSeen = '/last-seen';
    const String terms = '/terms';
    const String privacyPolicy = '/privacy-policy';
    const String sign = '/sign';
    const String monitor = '/monitor';
    const String monitorDetails = '/monitor-details';
    const String payment = '/payment';
    const String paymentSuccess = '/payment-success';
    const String paymentFailed = '/payment-failed';
    
    final dynamic args = settings.arguments;
    
      switch (settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const Main(), settings: settings);
      case onlineChecker: 
        return MaterialPageRoute(builder: (_) => const OnlineChecker(), settings: settings);
      case lastSeen:
        return MaterialPageRoute(builder: (_) => const LastSeen(), settings: settings);
      case terms:
        return MaterialPageRoute(builder: (_) => const TermsOfService(), settings: settings);
      case privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicy(), settings: settings);
      case sign:
        return MaterialPageRoute(builder: (_) => const Sign(), settings: settings);
      case monitor:
        User? user = FirebaseAuth.instance.currentUser;
        if(user == null){
          return errorRoute();
        }else{
          return MaterialPageRoute(builder: (_) => const Monitor(), settings: settings);
        }
      case monitorDetails:
        User? user = FirebaseAuth.instance.currentUser;
        if(user == null || args == null) {
          return errorRoute();
        }else{
          return MaterialPageRoute(builder: (_) => Details(number: args), settings: settings);
        }
      case payment:
        return MaterialPageRoute(builder: (_) => Payment(isFreeTrialOver: args), settings: settings);
      case paymentSuccess:
        return MaterialPageRoute(builder: (_) => const Success(), settings: settings);
      case paymentFailed:
        return MaterialPageRoute(builder: (_) => const Failed(), settings: settings);
      default: 
        return errorRoute();
    }

  }

  static Route<dynamic>? errorRoute(){
    return MaterialPageRoute(builder: (BuildContext context){
      SizeConfig.init(context);
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 17, 19),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText('404', gradient: const LinearGradient(colors: [Color.fromARGB(255, 245, 245, 245), Color.fromARGB(255, 255, 255, 255)], begin: Alignment.centerLeft, end: Alignment.centerRight), style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 350 ? 80 : SizeConfig.screenWidth! < 400 ? 100 : SizeConfig.screenWidth! < 500 ? 120 : SizeConfig.screenWidth! < 600 ? 140 : SizeConfig.screenWidth! < 800 ? 180 : SizeConfig.screenWidth! < 1200 ? 220 : 300, fontWeight: FontWeight.w700, letterSpacing: SizeConfig.screenWidth! < 350 ? 30 : SizeConfig.screenWidth! < 400 ? 35 : SizeConfig.screenWidth! < 600 ? 40 : SizeConfig.screenWidth! < 800 ? 50 : 60, height: 1)),
              SizedBox(width: SizeConfig.screenWidth! * .5, child: Center(child: Text("You didn't break the internet, but we can't find what you are looking for.",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: SizeConfig.screenWidth! < 350 ? 8 : SizeConfig.screenWidth! < 400 ? 9 : SizeConfig.screenWidth! < 600 ? 12 : SizeConfig.screenWidth! < 800 ? 14 : SizeConfig.screenWidth! < 1200 ? 16 : 18, fontWeight: FontWeight.w200)))),
              Space.spaceHeight(60),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text('Back to Home', style: GoogleFonts.poppins(fontSize: 16, color: ProjectColors.themeColorMOD5)),
                ),
              ),
            ],
        ),
          )),
      );
    });
  } 
}