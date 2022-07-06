import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/screens/screens.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  bool isFirstView = true;

  @override
  Widget build(BuildContext context) {

    SizeConfig.init(context);
    return Scaffold(
        body: Center(
        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(color: ProjectColors.themeColorMOD3),
                            width: 400,
                            height: SizeConfig.screenHeight,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  appBar(context),
                                  firstView(),
                                  Space.spaceHeight(20)
                                  // Column(
                                  //   children: [
                                  //     TextFormField(
                                  //       focusNode: focusNodes[0],
                                  //       controller: controllers[0],
                                  //       style: const TextStyle(color: Colors.white, fontSize: 16),
                                  //       decoration: _inputDec('Card Holder Name', 'ASd'),
                                  //     ),
                                  //     Space.spaceHeight(15),
                                  //     TextFormField(
                                  //       focusNode: focusNodes[1],                                      
                                  //       controller: controllers[1],
                                  //       style: const TextStyle(color: Colors.white, fontSize: 16),
                                  //       decoration: _inputDec('Card Number', 'asd'),
                                  //     ),
                                  //     Space.spaceHeight(15),
                                  //     TextFormField(
                                  //       focusNode: focusNodes[2],                                      
                                  //       controller: controllers[2],
                                  //       style: const TextStyle(color: Colors.white, fontSize: 16),
                                  //       decoration: _inputDec('Expiration Date', 'asd'),
                                  //     ),
                                  //     Space.spaceHeight(15),
                                  //     TextFormField(
                                  //       obscureText: true,
                                  //       maxLength: 3,
                                  //       focusNode: focusNodes[3],                                      
                                  //       controller: controllers[3],
                                  //       style: const TextStyle(color: Colors.white, fontSize: 16),
                                  //       decoration: _inputDec('CVV / CVC', 'asd'),
                                  //     ),
                                  //     Space.spaceHeight(15),
                                  //     Container(
                                  //       width: SizeConfig.screenWidth,
                                  //       height: 60,
                                  //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xffbff9a5c),),
                                  //       child: const Center(child: Text('Pay now', style: TextStyle(color: Colors.white,  fontSize: 18))),
                                  //       ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ),
      ),
    );
  }

  Widget firstView() {
    return Visibility(
      visible: isFirstView,
      child: Column(
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.screenWidth,
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Payment', style: GoogleFonts.poppins(fontSize: 30, color: Colors.white)),
                                            Space.spaceHeight(5),
                                            ProjectText.rText(text: 'welogger premium access', fontSize: 16, color: Colors.white24),
                                            Space.spaceHeight(30)
                                          ],
                                        ),
                                      ),
                                      Align(alignment: Alignment.centerLeft,child: ProjectText.rText(text: 'Billing Plan', fontSize: 20, color: ProjectColors.customColor)),
                                      Space.spaceHeight(20),
                                      SizedBox(
                                        width: 400,
                                        height: 120,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 170,
                                              height: 120,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(color: ProjectColors.themeColorMOD4, border: Border.all(color: const Color(0xffbff9a5c), width: 1)),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CircleAvatar(radius: 5, backgroundColor: const Color(0xffbff9a5c)),
                                                  ProjectText.rText(text: 'Billed Weekly', fontSize: 16, color: ProjectColors.customColor),
                                                  Stack(
                                                    children: [
                                                      SizedBox(width: 80, height: 40, child: ProjectText.rText(text: '4.99', fontSize: 30, color: const Color(0xffbff9a5c))),
                                                      Positioned(child: ProjectText.rText(text: r'$', fontSize: 14, color: const Color(0xffbff9a5c)))
                                                    ],
                                                  ),
                                                  ProjectText.rText(text: 'MEMBER PER WEEKLY', fontSize: 12, color: ProjectColors.greyColor)
                                                ],
                                              ),
                                            ),
                                            Space.spaceWidth(20),
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: 170,
                                                  height: 120,
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(color: ProjectColors.themeColorMOD4, border: Border.all(color: ProjectColors.greyColor, width: 1)),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      CircleAvatar(radius: 5, backgroundColor: ProjectColors.greyColor),
                                                      ProjectText.rText(text: 'Billed Annual', fontSize: 16, color: ProjectColors.customColor),
                                                      Stack(
                                                        children: [
                                                          SizedBox(width: 80, height: 40, child: ProjectText.rText(text: '12.99', fontSize: 30, color: const Color(0xffbff9a5c))),
                                                          Positioned(child: ProjectText.rText(text: r'$', fontSize: 14, color: const Color(0xffbff9a5c)))
                                                        ],
                                                      ),
                                                      ProjectText.rText(text: 'MEMBER PER ANNUAL', fontSize: 12, color: ProjectColors.greyColor)
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: -10,
                                                  right: -10,
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green, border: Border.all(color: Colors.white, width: 1)),
                                                    child: Center(child: ProjectText.rText(text: '-90%', fontSize: 12)),
                                                
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Space.spaceHeight(20),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Payment Method', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16))),
                                      Space.spaceHeight(20),
                                      _buildCreditCard(),
                                      Space.spaceHeight(20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        ProjectText.rText(text: 'Total Price:', fontSize: 18, fontWeight: FontWeight.bold),
                                        ProjectText.rText(text: r'4.99$', fontSize: 18, fontWeight: FontWeight.bold),
                                      ]),
                                      Space.spaceHeight(50),
                                      GestureDetector(
                                        onTap: (() {
                                          // showDialog(context: context, builder: (BuildContext context){
                                          //   return 
                                          // });
                                          setState(() => isFirstView = false);
                                        }),
                                        child: Container(
                                          width: SizeConfig.screenWidth,
                                          height: 60,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xffbff9a5c)),
                                          child: Center(child: Text('Continue', style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500))),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

  Container appBar(BuildContext context) {
    return Container(
                                  width: 400,
                                  height: 80,
                                  color: ProjectColors.themeColorMOD3,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: (() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PaymentPage()))),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: ProjectColors.themeColorMOD4,
                                              ),
                                            child: const Icon(Icons.keyboard_arrow_left, color: const Color(0xffbff9a5c), size: 25),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutSubscriptions())),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: ProjectColors.themeColorMOD4,
                                            ),
                                            child: const Icon(Icons.question_mark, color: const Color(0xffbff9a5c), size: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
  }

    Container _buildPhoneMethod() {
    return Container(
                                width: SizeConfig.screenWidth,
                                height: 60,
                                decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepOrange, const Color(0xffbff9a5c), const Color(0xffbff9a5c).withOpacity(0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight), border: Border.all(color: Colors.white, width: 1), borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Space.spaceWidth(10),
                                        const Icon(Icons.phone_android, color: Colors.white, size: 25),
                                        Space.spaceWidth(20),
                                        Text('+00 100 **** ** **', style: GoogleFonts.roboto(color: const Color.fromARGB(219, 255, 255, 255), fontSize: 16)),
                                      ],
                                    ),
                                    Align(
                                    alignment: Alignment.topRight,
                                    child: Container(width: 80, height: 30, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)), child: const Center(child: Text('PHONE', style: TextStyle(color: Colors.black),)),)),
                                  ],
                                ),
                              );
  }

  Stack _buildCreditCard() {
    return Stack(
                                children: [
                                  Opacity(
                                    opacity: 1,
                                    child: Container(
                                      width: SizeConfig.screenWidth,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white, width: 1),
                                        gradient: LinearGradient(colors: [Colors.blue.withOpacity(1),Colors.lightBlue, Colors.blue.withOpacity(0.6)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(width: 80, height: 30, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)), child: Center(child: Text('CARD', style: TextStyle(color: Colors.black),)),)),
                                          Space.spaceHeight(10),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ProjectText.rText(text: 'Card Number', fontSize: 14, color: Colors.white),
                                                Space.spaceHeight(2),
                                                Text('0123  4567  8901  2345', style: GoogleFonts.roboto(fontSize: 14, color: Color.fromARGB(221, 255, 255, 255), letterSpacing: 2)),
                                                Space.spaceHeight(10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        ProjectText.rText(text: 'Ex. Date', fontSize: 12, color: Colors.white),
                                                        Space.spaceHeight(2),
                                                        Text('01 / 19', style: GoogleFonts.roboto(fontSize: 12, color: Colors.white.withOpacity(0.9), letterSpacing: 1))
                                                        
                                                      ],
                                                    ),
                                                    Space.spaceWidth(20),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        ProjectText.rText(text: 'CVV', fontSize: 12, color: Colors.white),
                                                        Space.spaceHeight(3),
                                                        Text('***', style: GoogleFonts.roboto(fontSize: 12, color: Colors.white, letterSpacing: 1))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                          
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 45,
                                    child: ProjectText.rText(text: 'WEEKLY', fontSize: 40, color: Colors.black.withOpacity(0.1), fontWeight: FontWeight.w500, letterSpacing: 20)),
                                ],
                              );
  }

  InputDecoration _inputDec(String labelText, String hintText) {
    return InputDecoration(
      floatingLabelStyle: const TextStyle(color: Colors.white),
      labelStyle: const TextStyle(color: Colors.white60),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white38),
                                    labelText: labelText,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white54, width: 1),borderRadius: BorderRadius.circular(12)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.circular(12)
                                    )
                                  );
  }
}