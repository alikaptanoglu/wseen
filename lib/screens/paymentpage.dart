// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wseen/helpers/xmlpayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wseen/helpers/helpers.dart';
import 'package:wseen/models/bar.dart';
import 'package:wseen/models/loading.dart';
import 'package:wseen/models/utils.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';
import 'package:awesome_card/awesome_card.dart';

class Payment extends StatefulWidget {
  final bool isFreeTrialOver;
  const Payment({Key? key, required this.isFreeTrialOver}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  late BuildContext loadingContext;
  String expiryDate = '';
  String cardNumber = '';
  String cvvCode = '';
  String cardHolderName = '';
  bool showBack = false;
  int siparisCount = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode _focusNode;
  final List<TextEditingController> controllers = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(), TextEditingController()];
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    FirebaseFirestore.instance.collection('webpayment').snapshots().asBroadcastStream().listen((event) {
      setState(() {
        siparisCount = event.docs.length;
      });
    });
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if(!mounted) return;
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Column(
            children: [
              const CustomBar(),
              Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 22, 22, 25), Colors.black, Color.fromARGB(255, 15, 17, 19)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                width: SizeConfig.screenWidth!,
                height: SizeConfig.screenHeight! - 60,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
                      _buildHeader(),
                      Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
                      _creditCards(),
                      Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
                      trialOver(),
                      Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
                      Container(
                        width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black, width: 1), color: Colors.white.withOpacity(0.8)),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: SizeConfig.screenWidth! < 400 ? 40 : 50,
                              child: Center(child: Text('LIFETIME MEMBERSHIP', style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 400 ? 14 : SizeConfig.screenWidth! < 600 ? 16 : 18, color: Colors.black, fontWeight: FontWeight.bold))),
                            ),
                            Space.dividerHorizantal(width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 - 40 : 460, color: const Color.fromARGB(255, 220, 220, 220)),
                            Container(
                              width: double.maxFinite,
                              height: SizeConfig.screenWidth! < 400 ? 40 : 50,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('TOTAL PRICE:', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: SizeConfig.screenWidth! < 400 ? 12 : SizeConfig.screenWidth! < 600 ? 14 : 16)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(r'$39.99', style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough, decorationColor: Colors.red, decorationThickness: 2, fontSize: SizeConfig.screenWidth! < 400 ? 10 : SizeConfig.screenWidth! < 600 ? 12 : 14)),
                                        Space.spaceWidth(2),
                                        Text(r'$12.99', style: GoogleFonts.poppins(color: Colors.green, fontWeight: FontWeight.bold, fontSize: SizeConfig.screenWidth! < 400 ? 14 : SizeConfig.screenWidth! < 600 ? 16 : 18)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
                      buildCreditCard(),
                      Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
                      buildForm(),
                      Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
                      buildButton(context),
                      Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  _pay() async {
    showDialog(builder: (BuildContext context) {
      loadingContext = context;
      return const LoadingThreeDots();
    }, context: context);
    var expireMoth = expiryDate.split('/')[0];
    var expireYear = expiryDate.split('/')[1];
    cardNumber = cardNumber.split(' ').join('');
    final Map paymentResult = await XMLPayment(cardHolderName, cardNumber, expireMoth, expireYear, cvvCode, 'lkadlfşlsvş$siparisCount', 'lkadlfşlsvş$siparisCount').request();
    Navigator.of(loadingContext).pop();
    final int sonuc = int.parse(paymentResult['Sonuc']);
    final int islemID = int.parse(paymentResult['Islem_ID']);
    final Uri paymentURL = Uri.parse(paymentResult['UCD_URL']);
    Provider.of<ModelProvider>(context, listen: false).setPaymentURL(paymentURL);
    if(sonuc > 0 && islemID > 0){
      await _launchInBrowser(paymentURL);
      Utils.showSnackBar(text: paymentResult['Sonuc_Str'], color: Colors.red);
      FirebaseFirestore.instance.collection('webpayment').doc().set({});
    } else  {
      Utils.showSnackBar(text: paymentResult['Sonuc_Str'], color: Colors.red);
    } 
  }
  // final String uid = FirebaseAuth.instance.currentUser!.uid;
  // FirebaseFirestore.instance.collection('webusers').doc(uid).update({'subscription_type': 'Premium'});
  //Navigator.of(context).pushNamedAndRemoveUntil('/payment-success', (route) => false);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url, 
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget buildForm() {
    return Form(
      child: SizedBox(
        width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
        child: Column(
          children: [
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r"[0-9]"))
              ],
              maxLength: 30,
              controller: controllers[0],
              onChanged: (value){
                setState(() {
                  cardHolderName = value;
                });
              },
              style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
              decoration: _inputDec('Card Holder Name', 'Name')
            ),
            Space.spaceHeight(15),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberFormatter()
              ],
              maxLength: 19,
              controller: controllers[1],
              onChanged: (value) {
                setState(() {
                  cardNumber = value;
                });
              },
              style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
              decoration: _inputDec('Card Number', 'Number')
            ),
            Space.spaceHeight(15),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! < 600 ? (SizeConfig.screenWidth! * .4) - 10 : 240,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CardDateFormatter()
                    ],
                    maxLength: 5,
                    controller: controllers[2],
                    onChanged: (value) {
                      setState(() {
                        expiryDate = value;
                      });
                    },
                    style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                    decoration: _inputDec('Ex. Date', 'Date')
                  ),
                ),
                Space.spaceWidth(20),
                SizedBox(
                  width: SizeConfig.screenWidth! < 600 ? (SizeConfig.screenWidth! * .4) - 10 : 240,
                  child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 3,
                  focusNode: _focusNode,
                  controller: controllers[3],
                  onChanged: (value) {
                    setState(() {
                      cvvCode = value;
                    });
                  },
                  style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                  decoration: _inputDec('CVV', 'Security Code')    
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDec(String labelText, String hintText) {
    return InputDecoration(
      counterText: '',
      floatingLabelStyle: const TextStyle(color: Colors.white),
      labelStyle: const TextStyle(color: Colors.white60),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white38),
      labelText: labelText,
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white54, width: 1),borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.circular(12))
    );
  }

  Widget buildCreditCard() {
    return CreditCard(
      width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
      height: 200,
      cardNumber: cardNumber,
      cardExpiry: expiryDate,
      cardHolderName: cardHolderName,
            cvv: cvvCode,
            bankName: 'Credit Card',
            showBackSide: showBack,
            frontBackground: Container(width: double.maxFinite, height: double.maxFinite, decoration: BoxDecoration(color: const Color(0xff0B0B0F), border: Border.all(color: Colors.white30, width: 1), borderRadius: BorderRadius.circular(10))),
            backBackground: CardBackgrounds.white,
            showShadow: true,
            mask: getCardTypeMask(cardType: CardType.americanExpress),
          );
  }

  Widget showOffer() {
    return Container(
      width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
      height: 250,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: ProjectColors.themeColorMOD5.withOpacity(0.3)),
      child: Column(
        children: [
          Container(
            width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
            height: 50,
            decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)), color: ProjectColors.themeColorMOD5.withOpacity(0.5)),
            child: Center(child: Text('Lifetime Premium Membership'.toUpperCase(), style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 350 ? 12 : SizeConfig.screenWidth! < 400 ? 14 : SizeConfig.screenWidth! < 500 ? 16 : 18, color: Colors.white, letterSpacing: 1))),
          ),
          SizedBox(
            width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(r'12.99 USD / Lifetime', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 18 : SizeConfig.screenWidth! < 400 ? 20 : SizeConfig.screenWidth! < 500 ? 22 : 26, color: Colors.white, fontWeight: FontWeight.bold)),
                Space.spaceHeight(10),
                Text('Full features', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 15 : SizeConfig.screenWidth! < 400 ? 16 : SizeConfig.screenWidth! < 500 ? 17 : 18, color: Colors.white.withAlpha(150))),
                Space.spaceHeight(10),
                Text('Support 24/7', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 15 : SizeConfig.screenWidth! < 400 ? 16 : SizeConfig.screenWidth! < 500 ? 17 : 18, color: Colors.white.withAlpha(150))),
                Space.spaceHeight(20),
                GestureDetector(
                  onTap: () => null,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .6 : 400,
                      height: SizeConfig.screenWidth! < 400 ? 40 : 50,
                      decoration: BoxDecoration(color: ProjectColors.themeColorMOD5.withAlpha(200), borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.white.withAlpha(100), width: 1)),
                      child: Center(child: Text('Active Plan'.toUpperCase(), style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 350 ? 13 : SizeConfig.screenWidth! < 400 ? 14 : SizeConfig.screenWidth! < 500 ? 15 : 16, color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
    );
  }

  Widget trialOver() {
    return Visibility(
      visible: widget.isFreeTrialOver,
      child: Container(
        width: SizeConfig.screenWidth! < 500 ? SizeConfig.screenWidth! * .8 : 400,
        height: 50,
        decoration: BoxDecoration(color: const Color.fromARGB(255, 139, 65, 18), border: Border.all(color: const Color.fromARGB(255, 255, 171, 119)), borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your 8-hour trial is over', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 300 ? 9 : SizeConfig.screenWidth! < 400 ?  10 : 12, color: const Color.fromARGB(255, 255, 210, 182), fontWeight: FontWeight.w700), textAlign: TextAlign.center),
            Space.spaceHeight(2),
            Text('Buy premium to continue using Wseen.', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 300 ? 9 : SizeConfig.screenWidth! < 400 ? 10 : 12, color:const Color.fromARGB(255, 255, 210, 182), fontWeight: FontWeight.w400), textAlign: TextAlign.center),
          ],
        )
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Provider.of<ModelProvider>(context, listen: false).setSignState(1);
          _pay();
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
            height: SizeConfig.screenWidth! < 600 ? 50 : 60,
            decoration: BoxDecoration(borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20)), color: ProjectColors.themeColorMOD5),
            child: Center(child: Text('PAY  NOW', style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 400 ? 16 : SizeConfig.screenWidth! < 600 ? 18 : 20, color: Colors.white, fontWeight: FontWeight.bold))),
          ),
        ),
      );
  }

  Widget _buildHeader() {
    double w = SizeConfig.screenWidth!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.creditCard, color: ProjectColors.themeColorMOD5, size: w < 300 ? 15 : w < 400 ? 17 : w < 600 ? 20 : 25),
        Space.spaceWidth(w < 300 ? 10 : w < 400 ? 15 : 20),
        Text('Purchase Subscription', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: w < 300 ? 16 : w < 400 ? 20 : w < 600 ? 22 : 25)),
      ],
    );
  }

  

  Row _creditCards() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          width: SizeConfig.screenWidth! < 350 ? 40 : 60, height: SizeConfig.screenWidth! < 350 ? 20 : 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), image: DecorationImage(image: ImageEnums.visalogo.assetImage, fit: BoxFit.cover))),
        Space.spaceWidth(10),
        Container(
          width: SizeConfig.screenWidth! < 350 ? 40 : 60, height: SizeConfig.screenWidth! < 350 ? 20 : 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), image: DecorationImage(image: ImageEnums.mastercardlogo.assetImage, fit: BoxFit.cover))),
        Space.spaceWidth(10),
        Container(
          width: SizeConfig.screenWidth! < 350 ? 40 : 60, height: SizeConfig.screenWidth! < 350 ? 20 : 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), image: DecorationImage(image: ImageEnums.americanexpresslogo.assetImage, fit: BoxFit.cover))),
        Space.spaceWidth(10),
        Container(
          width: SizeConfig.screenWidth! < 350 ? 40 : 60, height: SizeConfig.screenWidth! < 350 ? 20 : 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), image: DecorationImage(image: ImageEnums.discovernetworklogo.assetImage, fit: BoxFit.cover))),
      ]);
  }
}


class PBUTTONpainter extends CustomPainter{
  final double sizeWidth;
  PBUTTONpainter(this.sizeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final double value = sizeWidth < 400 ? 25 : sizeWidth < 600 ? 30 : sizeWidth < 800 ? 35 : 40;
    Paint paint = Paint()..color = ProjectColors.themeColorMOD5..style = PaintingStyle.fill;
    Path path = Path()..moveTo(10, 0);
    path.quadraticBezierTo(0, 0, 0, 10);
    path.lineTo(0, size.height - 10);
    path.quadraticBezierTo(0, size.height, 10, size.height);
    path.lineTo(size.width - value - 3, size.height);
    path.quadraticBezierTo(size.width - value, size.height, size.width - value + 3, size.height - 3);
    path.lineTo(size.width - 2, (size.height/2) + 2);
    path.quadraticBezierTo(size.width, size.height/2, size.width - 2, (size.height/2) - 2);
    path.lineTo(size.width - value + 3, 3);
    path.quadraticBezierTo(size.width - value, 0, size.width - value - 3, 0);
    path.lineTo(size.width - value, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}










// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:wseen/helpers/helpers.dart';
// import 'package:wseen/models/bar.dart';
// import 'package:wseen/products/products.dart';
// import 'package:wseen/providers/providers.dart';

// class Payment extends StatefulWidget {
//   final bool isFreeTrialOver;
//   const Payment({Key? key, required this.isFreeTrialOver}) : super(key: key);

//   @override
//   State<Payment> createState() => _PaymentState();
// }

// class _PaymentState extends State<Payment> {

//   ModelProvider modelProvider = ModelProvider();
//   final List<TextEditingController> controllers = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];
//   final List<FocusNode> focusNodes = [FocusNode(),FocusNode(),FocusNode(),FocusNode(),FocusNode()];
//   final List<List> lists = [[],[],[],[],[]];
//   final List<bool> cardNumberContains = [false,false,false,false];

//   @override
//   void initState(){

//     lists[0] = bankCards['visa']['begin'];
//     lists[1] = bankCards['master']['begin'];
//     lists[2] = bankCards['americanexpress']['begin'];
//     lists[3] = bankCards['discover']['begin'];
//     lists[4] = lists[0] + lists[1] + lists[2] + lists[3];

//     for(var controller in controllers){
//       controller.addListener(() { 
//         if(controllers[0].text.isNotEmpty){
//           Provider.of<ModelProvider>(context, listen: false).getCardHolderName(controllers[0].text);
//         }else{
//           Provider.of<ModelProvider>(context, listen: false).getCardHolderName('Card Holder Name');
//         }
//         Provider.of<ModelProvider>(context, listen: false).getCardNumber(controllers[1].text);
//         Provider.of<ModelProvider>(context, listen: false).getExpirationDate(controllers[2].text);
//         Provider.of<ModelProvider>(context, listen: false).getSecurityCode(controllers[3].text);

//         for(var i = 0; i < 4; i++){
//           if(controllers[i].text.isEmpty){
//             Provider.of<ModelProvider>(context, listen: false).getPaymentFieldIsNotEmpty(false);
//           }else{
//             Provider.of<ModelProvider>(context, listen: false).getPaymentFieldIsNotEmpty(true);
//           }
//         }

//         if(getCard() != null){
//           cardNumberContains[getCard()!] = true;
//         }else{
//           for(var i = 0; i < 4; i++){
//             cardNumberContains[i] = false;
//           }
//         }
//       });
//     }
    
//     super.initState();
//   }

//   int? getCard(){
//     for(var value in lists[4]){
//       if(Provider.of<ModelProvider>(context, listen: false).cardNumber.startsWith(value, 0)){
//         for(var i = 0; i < 4; i++){
//           if(lists[i].contains(value)){
//             return i;
//           }
//         }
//       }
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     return Scaffold(
//         body: SizedBox(
//           width: SizeConfig.screenWidth,
//           height: SizeConfig.screenHeight,
//           child: Column(
//             children: [
//               const CustomBar(),
//               Container(
//                 decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 22, 22, 25), Colors.black, Color.fromARGB(255, 15, 17, 19)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//                 width: SizeConfig.screenWidth!,
//                 height: SizeConfig.screenHeight! - 80,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
//                       _buildHeader(),
//                       Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
//                       _creditCards(),
//                       Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
//                       Visibility(
//                         visible: widget.isFreeTrialOver,
//                         child: Container(
//                           width: SizeConfig.screenWidth! < 500 ? SizeConfig.screenWidth! * .8 : 400,
//                           height: 50,
//                           decoration: BoxDecoration(color: const Color.fromARGB(255, 139, 65, 18), border: Border.all(color: const Color.fromARGB(255, 255, 171, 119)), borderRadius: BorderRadius.circular(5)),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('Your 8-hour trial is over', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 300 ? 9 : SizeConfig.screenWidth! < 400 ?  10 : 12, color: const Color.fromARGB(255, 255, 210, 182), fontWeight: FontWeight.w700), textAlign: TextAlign.center),
//                               Space.spaceHeight(2),
//                               Text('Buy premium to continue using Wseen.', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 300 ? 9 : SizeConfig.screenWidth! < 400 ? 10 : 12, color:const Color.fromARGB(255, 255, 210, 182), fontWeight: FontWeight.w400), textAlign: TextAlign.center),
//                             ],
//                           )
//                         ),
//                       ),
//                       Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
//                       Container(
//                         width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//                         height: 250,
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: ProjectColors.themeColorMOD5.withOpacity(0.3)),
//                         child: Column(
//                           children: [
//                             Container(
//                               width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//                               height: 50,
//                               decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)), color: ProjectColors.themeColorMOD5.withOpacity(0.5)),
//                               child: Center(child: Text('Lifetime Premium Membership'.toUpperCase(), style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 350 ? 12 : SizeConfig.screenWidth! < 400 ? 14 : SizeConfig.screenWidth! < 500 ? 16 : 18, color: Colors.white, letterSpacing: 1))),
//                             ),
//                             SizedBox(
//                               width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//                               height: 200,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(r'12.99 USD / Lifetime', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 18 : SizeConfig.screenWidth! < 400 ? 20 : SizeConfig.screenWidth! < 500 ? 22 : 26, color: Colors.white, fontWeight: FontWeight.bold)),
//                                   Space.spaceHeight(10),
//                                   Text('Full features', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 15 : SizeConfig.screenWidth! < 400 ? 16 : SizeConfig.screenWidth! < 500 ? 17 : 18, color: Colors.white.withAlpha(150))),
//                                   Space.spaceHeight(10),
//                                   Text('Support 24/7', style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 15 : SizeConfig.screenWidth! < 400 ? 16 : SizeConfig.screenWidth! < 500 ? 17 : 18, color: Colors.white.withAlpha(150))),
//                                   Space.spaceHeight(20),
//                                   GestureDetector(
//                                     onTap: () => null,
//                                     child: MouseRegion(
//                                       cursor: SystemMouseCursors.click,
//                                       child: Container(
//                                         width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .6 : 400,
//                                         height: SizeConfig.screenWidth! < 400 ? 40 : 50,
//                                         decoration: BoxDecoration(color: ProjectColors.themeColorMOD5.withAlpha(200), borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.white.withAlpha(100), width: 1)),
//                                         child: Center(child: Text('Active Plan'.toUpperCase(), style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 350 ? 13 : SizeConfig.screenWidth! < 400 ? 14 : SizeConfig.screenWidth! < 500 ? 15 : 16, color: Colors.white))),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ]),
//                       ),
//                       Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
//                       buildCard(),
//                       Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
//                       buildForm(),
//                       Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
//                       buildButton(context),
//                       Space.spaceHeight(SizeConfig.screenWidth! < 400 ? 15 : SizeConfig.screenWidth! < 500 ? 20 : 25),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//     );
//   }

//   GestureDetector buildButton(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           Provider.of<ModelProvider>(context, listen: false).setSignState(1);
//           //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
//         },
//         child: Container(
//           width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//           height: SizeConfig.screenWidth! < 600 ? 50 : 60,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) , color: Provider.of<ModelProvider>(context, listen: false).paymentFieldIsNotEmpty ? ProjectColors.themeColorMOD5 : ProjectColors.themeColorMOD5.withAlpha(100)),
//           child: Center(child: Text('Confirm', style: GoogleFonts.poppins(color: Provider.of<ModelProvider>(context, listen: false).paymentFieldIsNotEmpty ? ProjectColors.customColor : ProjectColors.customColor.withAlpha(100), fontSize: 20, fontWeight: FontWeight.w500))),
//         ),
//       );
//   }


//   Widget _buildHeader() {
//     double w = SizeConfig.screenWidth!;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(FontAwesomeIcons.creditCard, color: ProjectColors.themeColorMOD5, size: w < 300 ? 15 : w < 400 ? 17 : w < 600 ? 20 : 25),
//         Space.spaceWidth(w < 300 ? 10 : w < 400 ? 15 : 20),
//         Text('Purchase Subscription', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: w < 300 ? 16 : w < 400 ? 20 : w < 600 ? 22 : 25)),
//       ],
//     );
//   }

//   Widget loading() {
//     return SizedBox(
//       width: 400,
//       height: SizeConfig.screenHeight! - 201,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(width: 20, height: 20,child: CircularProgressIndicator(color: ProjectColors.themeColorMOD5,strokeWidth: 3)),
//           Space.spaceHeight(5),
//           ProjectText.rText(text: 'Please wait', fontSize: 12, color: ProjectColors.themeColorMOD5.withAlpha(200))
//         ],
//       ));
//   }

//   buildCard(){
//     return Container(
//       padding: const EdgeInsets.all(20),
//       width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//       height: SizeConfig.screenWidth! < 350 ? 140 : 160,
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white10, width: 1),color: const Color.fromARGB(255, 22, 25, 30)),
//       child: Column(
//         children: [
//         const Align(alignment: Alignment.centerRight,child: Icon(FontAwesomeIcons.solidCreditCard, color: Colors.white, size: 20)),
//         Space.expandedSpace(),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: SizedBox(
//             height: 20,
//             child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemCount: 20,
//               itemBuilder: (BuildContext context, int index){
//                 String cardNumber = Provider.of<ModelProvider>(context, listen: false).cardNumber;
//                 return Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       (index + 1) % 5 == 0 ? Space.emptySpace : Text(cardNumber.length > index && index > 14 ? cardNumber.substring(index, index + 1) : 'x', style: GoogleFonts.roboto(fontSize: cardNumber.length > index && index > 14 ? SizeConfig.screenWidth! < 350 ? 12 : 14 : SizeConfig.screenWidth! < 350 ? 12 : 20, color: cardNumber.length > index ? ProjectColors.customColor : Colors.white70, fontWeight: FontWeight.w300)),
//                       Space.spaceWidth((index + 1) % 5 == 0 ?  SizeConfig.screenWidth! < 350 ? 5 : 10 :  SizeConfig.screenWidth! < 350 ? 3 : 2),
//                     ],
//                   );
//               }),
//           ),
//         ),
//       Space.spaceHeight(12),
//       Row(
//         children: [
//           Text(Provider.of<ModelProvider>(context).expirationDate.length >= 2 ? Provider.of<ModelProvider>(context, listen: false).expirationDate.substring(0,2) : 'MM', style: GoogleFonts.roboto(fontSize:  SizeConfig.screenWidth! < 350 ? 12 : 14, color: Provider.of<ModelProvider>(context, listen: false).expirationDate.length > 1 ? ProjectColors.customColor : Colors.white70, fontWeight: FontWeight.w300)),
//           Text(' / ', style: GoogleFonts.roboto(fontSize:  SizeConfig.screenWidth! < 350 ? 12 : 14, color: Provider.of<ModelProvider>(context).expirationDate.length > 2 ? ProjectColors.customColor : Colors.white12)),
//           Text( Provider.of<ModelProvider>(context).expirationDate.length >= 5 ? Provider.of<ModelProvider>(context, listen: false).expirationDate.substring(3,5) : 'YY', style: GoogleFonts.roboto(fontSize:  SizeConfig.screenWidth! < 350 ? 12 : 14, color: Provider.of<ModelProvider>(context, listen: false).expirationDate.length > 4 ? ProjectColors.customColor : Colors.white70, fontWeight: FontWeight.w300)),
//           Space.spaceWidth(10),
//           Text(Provider.of<ModelProvider>(context, listen: false).securityCode.isNotEmpty ? Provider.of<ModelProvider>(context, listen: false).securityCode : 'CVV', style: GoogleFonts.roboto(color: Provider.of<ModelProvider>(context, listen: false).securityCode.isNotEmpty ? ProjectColors.customColor : Colors.white70, fontSize:  SizeConfig.screenWidth! < 350 ? 12 : 14, fontWeight: FontWeight.w300)),
//         ],
//       ),
//       Space.spaceHeight(10),
//       Align(alignment: Alignment.centerLeft,child: Text(Provider.of<ModelProvider>(context,listen: false).cardHolderName.toUpperCase(), style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 12 : 14, color: Provider.of<ModelProvider>(context,listen: false).cardHolderName == 'Card Holder Name' ? Colors.white70 : ProjectColors.customColor)))
//       ]),
//     );
//   }

//   Row _creditCards() {
//     return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//         Container(
//           width: SizeConfig.screenWidth! < 350 ? 40 : 60, height: SizeConfig.screenWidth! < 350 ? 20 : 30,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), image: DecorationImage(image: ImageEnums.visalogo.assetImage, fit: BoxFit.cover))),
//         Space.spaceWidth(10),
//         Container(
//           width: SizeConfig.screenWidth! < 350 ? 40 : 60, height: SizeConfig.screenWidth! < 350 ? 20 : 30,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), image: DecorationImage(image: ImageEnums.mastercardlogo.assetImage, fit: BoxFit.cover))),
//         Space.spaceWidth(10),
//         Container(
//           width: SizeConfig.screenWidth! < 350 ? 40 : 60, height: SizeConfig.screenWidth! < 350 ? 20 : 30,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), image: DecorationImage(image: ImageEnums.americanexpresslogo.assetImage, fit: BoxFit.cover))),
//         Space.spaceWidth(10),
//         Container(
//           width: SizeConfig.screenWidth! < 350 ? 40 : 60, height: SizeConfig.screenWidth! < 350 ? 20 : 30,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), image: DecorationImage(image: ImageEnums.discovernetworklogo.assetImage, fit: BoxFit.cover))),
//       ]);
//   }

//   Map bankCards = {
//     'visa': {
//       'begin': ['4'],
//       'length': ['13','19']
//     },
//     'master':{
//       'begin': ['51', '55', '222100', '272099'],
//       'length': ['16']    
//     },
//     'americanexpress': {
//       'begin': ['500000', '509999', '560000', '589999', '600000', '699999'],
//       'length': ['15']
//     },
//     'discover': {
//       'begin': ['6011', '622126', '622925', '644', '649', '65'],
//       'length': ['16']
//     }
//   };

// }