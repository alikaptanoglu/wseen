// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/screens/screens.dart';
import '../../main.dart';

int value = 0;

class PaymentPage extends StatefulWidget {
  final String? number;
  final String? name;
  const PaymentPage({ Key? key, this.number, this.name }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  final List<TextEditingController> controllers = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];
  final List<FocusNode> focusNodes = [FocusNode(),FocusNode(),FocusNode(),FocusNode()];
  final int maxContact = FirebaseRemoteConfig.instance.getInt('max_contact');

  @override
  void initState() {
    for(var controller in controllers){
      controller.addListener(() { 
        print(controller.text);
      });
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
      return Scaffold(
      body: SafeArea(
        top:false,
        child: Center(
          child: Container(
            height: SizeConfig.screenHeight!,
            width: 400,
            decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.mobileonboardtwo.assetImage,alignment: Alignment.topCenter),
            gradient: const LinearGradient(colors: [Color.fromARGB(255, 21, 21, 29),  Color.fromARGB(255, 24, 20, 36), Color.fromARGB(255, 34, 24, 59),],begin: Alignment.center, end: Alignment.topCenter)),
            child: Container(
              height: 400,
              width: SizeConfig.screenWidth!,
              decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(colors: [const Color.fromARGB(255, 21, 21, 29),const Color.fromARGB(255, 15, 15, 23),const Color.fromARGB(255, 5, 5, 13),Colors.black,Colors.black.withOpacity(0.6)], stops: const [0.30, 0.35, 0.4, 0.45, 0.6], begin: Alignment.bottomCenter, end: Alignment.topCenter)
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(parsedJson['paymentHead'], style: GoogleFonts.roboto(fontSize: 35, color:Colors.white,fontWeight: FontWeight.w700,letterSpacing: 1), textAlign: TextAlign.center,),
                      Space.spaceHeight(25),
                      _offers(),
                      Space.spaceHeight(25),
                      _weeklyButton(),
                      Space.spaceHeight(5),
                      _yearlyButton(),
                      Space.spaceHeight(20),
                      _button(),
                      Space.spaceHeight(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _offers() {
    return Column(
                  children: [
                    _row('assets/images/ic_cancelicon.png',parsedJson['offer1']),
                    Space.spaceHeight(15),
                    _row('assets/images/ic_freetrial.png',parsedJson['offer2']),
                    Space.spaceHeight(15),
                    _row('assets/images/ic_instantnotifications.png', parsedJson['offer3']),
                  ],
                );
  }

      //     Positioned(
          //       right: 20,
          //       top: 20,
          //       child: SafeArea(
          //       child: GestureDetector(
          //         onTap: (){
          //           Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => const HomePage()),(route) => false);
          //         },
          //       child: const Icon(Icons.close, color: Colors.white, size: 25),
          //     ),
          //   ),
          // ),


  Widget _row(icon, text) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(icon, color: const Color(0xffbff9a5c), width: 20, height: 20,),
                      Space.spaceWidth(15),
                      Text(text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                    ],
                  ),
    );
  }

  Widget _button() {
    return GestureDetector(
                  onTap: () {
                    navigateToPayment();
                  },
                  
                  child: Container(
                    width: SizeConfig.screenWidth!,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                    decoration: BoxDecoration(color: const Color(0xffbff9a5c), borderRadius: BorderRadius.circular(15)),
                    child: Center(child: FittedBox(
                      child: Text(value == 1 ? parsedJson['buttonannualtext'] : parsedJson['buttonweeklytext'], style:GoogleFonts.poppins(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 20)),
                    )),
                  ),
                );
  }

  Widget _yearlyButton() {
    return GestureDetector(
                onTap: (){
                  setState(() {
                    value = 1;
                  });
                },
                child: Container(
                  width: SizeConfig.screenWidth!,
                  height: 60,
                  constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: value == 1 ? const Color(0xffbff9a5c): const Color(0xffbff9a5c) .withAlpha(50), width: 2),
                  gradient:LinearGradient(colors: [const Color(0xffbff9a5c).withOpacity(0.0),value == 1 ?const Color(0xffbff9a5c).withOpacity(0.4) :Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: value == 1 ? const Color(0xffbff9a5c) : const Color(0xffbff9a5c).withAlpha(50), width: 2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: value == 1 ? const Color(0xffbff9a5c) : Colors.transparent,
                              ),
                            ),
                          ),
                          Space.spaceWidth(20),
                          Text(parsedJson['annual'], style: const TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Container(
                        width: 70,
                        height: 25,
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xffbff9a5c),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(child: FittedBox(
                          child: Text(
                            parsedJson['save'],style: const TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )),
                      ),
                    ],
                  ),
                ));
  }

  Widget _weeklyButton() {
    return GestureDetector(
                onTap: (){
                  setState(() {
                    value = 0;
                  });
                },
                child: Container(
                  width: SizeConfig.screenWidth!,
                  height: 60,
                  constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: value == 0 ?  const Color(0xffbff9a5c) : const Color(0xffbff9a5c).withAlpha(50), width: 2),
                  gradient:LinearGradient(colors: [ const Color(0xffbff9a5c).withOpacity(0.0),value == 0 ? const Color(0xffbff9a5c).withOpacity(0.4) :Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: value == 0 ? const Color(0xffbff9a5c) :  const Color(0xffbff9a5c).withAlpha(50), width: 2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: value == 0 ?  const Color(0xffbff9a5c) : Colors.transparent,
                              ),
                            ),
                          ),
                          Space.spaceWidth(20),
                          Text(parsedJson['weekly'], style: const TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ));
  }
  
  navigateToPayment(){
    Navigator.push(context, PageRouteBuilder(
    pageBuilder: ((context, animation, secondaryAnimation) => const Payment()),
    transitionsBuilder: (context, anim, secondaryAnimation, child) => FadeTransition(opacity: anim, child: child),
    transitionDuration: const Duration(milliseconds: 500)
    ));
  }
}

