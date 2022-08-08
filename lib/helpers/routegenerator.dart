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
  static Route<dynamic>? generateRoute(RouteSettings settings){
    final dynamic args = settings.arguments;
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const Main());
      case '/online-checker': 
        return MaterialPageRoute(builder: (_) => const OnlineChecker());
      case '/last-seen':
        return MaterialPageRoute(builder: (_) => const LastSeen());
      case '/terms':
        return MaterialPageRoute(builder: (_) => const TermsOfService());
      case '/privacy-policy':
        return MaterialPageRoute(builder: (_) => const PrivacyPolicy());
      case '/sign':
        return MaterialPageRoute(builder: (_) => const Sign());
      case '/monitor':
        User? user = FirebaseAuth.instance.currentUser;
        if(user == null){
          return errorRoute();
        }else{
          return MaterialPageRoute(builder: (_) => const Monitor());
        }
      case '/monitor/details':
        User? user = FirebaseAuth.instance.currentUser;
        if(user == null || args == null) {
          return errorRoute();
        }else{
          return MaterialPageRoute(builder: (_) => Details(number: args));
        }
      case '/payment':
        return MaterialPageRoute(builder: (_) => Payment(isFreeTrialOver: args));
      case '/payment-success':
        return MaterialPageRoute(builder: (_) => const Success());
      case '/payment-failed':
        return MaterialPageRoute(builder: (_) => const Failed());
      default: 
        return errorRoute();
    }
  }

  static Route<dynamic>? errorRoute(){
    return MaterialPageRoute(builder: (BuildContext context){
      SizeConfig.init(context);
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText('404', gradient: const LinearGradient(colors: [Colors.black, Color.fromARGB(255, 15, 17, 19)], begin: Alignment.centerLeft, end: Alignment.centerRight), style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 350 ? 80 : SizeConfig.screenWidth! < 400 ? 100 : SizeConfig.screenWidth! < 500 ? 120 : SizeConfig.screenWidth! < 600 ? 140 : SizeConfig.screenWidth! < 800 ? 180 : SizeConfig.screenWidth! < 1200 ? 220 : 300, fontWeight: FontWeight.w700, letterSpacing: SizeConfig.screenWidth! < 350 ? 30 : SizeConfig.screenWidth! < 400 ? 35 : SizeConfig.screenWidth! < 600 ? 40 : SizeConfig.screenWidth! < 800 ? 50 : 60, height: 1)),
              SizedBox(width: SizeConfig.screenWidth! * .5, child: Center(child: Text("You didn't break the internet, but we can't find what you are looking for.",textAlign: TextAlign.center, style: TextStyle(color: Colors.black87, fontSize: SizeConfig.screenWidth! < 350 ? 8 : SizeConfig.screenWidth! < 400 ? 9 : SizeConfig.screenWidth! < 600 ? 12 : SizeConfig.screenWidth! < 800 ? 14 : SizeConfig.screenWidth! < 1200 ? 16 : 18, fontWeight: FontWeight.w200)))),
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