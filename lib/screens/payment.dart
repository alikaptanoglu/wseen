// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:wseen/products/products.dart';
// import 'package:wseen/providers/providers.dart';
// import 'package:wseen/screens/screens.dart';
// import '../../main.dart';


// class PaymentPage extends StatefulWidget {
//   final int value;
//   const PaymentPage({ Key? key, required this.value}) : super(key: key);

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {

//   int? value;
//   double? get maxWidth => SizeConfig.screenWidth! >= 400 ? 400 : SizeConfig.screenWidth; 

//   @override
//   Widget build(BuildContext context) {
//     value = widget.value;
//     SizeConfig.init(context);
//       return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 15, 17, 19),
//       body: SafeArea(
//         top:false,
//         child: Container(
//           height: SizeConfig.screenHeight!,
//           width: SizeConfig.screenWidth,
//           decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.mobileonboardtwo.assetImage, colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.dstIn) , alignment: Alignment.topCenter, repeat: ImageRepeat.repeat)),
//           child: SizedBox(
//             height: 400,
//             width: maxWidth!,
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text(parsedJson['paymentHead'], style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 25 : 35, color:Colors.white,fontWeight: FontWeight.w700,letterSpacing: 1), maxLines: 2, textAlign: TextAlign.center,),
//                     Space.spaceHeight(25),
//                     _offers(),
//                     Space.spaceHeight(20),
//                     _freeButton(),
//                     Space.spaceHeight(5),
//                     _premiumButton(),
//                     Space.spaceHeight(20),
//                     _continueButton(),
//                     Space.spaceHeight(20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _offers() {
//     return SizedBox(
//       width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _row('assets/images/ic_cancelicon.png',parsedJson['offer1']),
//           Space.spaceHeight(10),
//           _row('assets/images/ic_freetrial.png','8 Hours Free Membership'),
//           Space.spaceHeight(10),
//           _row('assets/images/ic_instantnotifications.png', 'Detailed Statistic'),
//         ],
//       ),
//     );
//   }

//   Widget _row(icon, text) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 40),
//       child: Row(
//         children: [
//           Image.asset(icon, color: ProjectColors.themeColorMOD5, width: 16, height: 16),
//           Space.spaceWidth(SizeConfig.screenWidth! < 350 ? 10 : 15),
//           Text(text, style: TextStyle(color: Colors.white, fontSize: SizeConfig.screenWidth! < 350 ? 14 : 16, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }

//   Widget _continueButton(){
//     return GestureDetector(
//       onTap: () => Provider.of<ModelProvider>(context, listen: false).subscriptionType == 0 ? navigateToHome() : navigateToPayment(),
//       child: Container(
//         width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//         height: 50,
//         margin: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: ProjectColors.themeColorMOD5,
//         ),
//         child: Center(child: Text('Continue', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white))),
//       ),
//     );
//   }

//   Widget _freeButton() {
//     return GestureDetector(
//       onTap: () => Provider.of<ModelProvider>(context, listen: false).setSubscriptionType(0),
//       child: Consumer<ModelProvider>(
//         builder: (context, value, child) {
//           return Container(
//             width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//             height: 50,
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! < 350 ? 10 : 15),
//             decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: value.subscriptionType == 0 ? ProjectColors.themeColorMOD5 : ProjectColors.themeColorMOD5.withAlpha(50), width: 2),
//             gradient:LinearGradient(colors: [ProjectColors.themeColorMOD5.withOpacity(0.0),value.subscriptionType == 0 ? ProjectColors.themeColorMOD5.withOpacity(0.4) :Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 30,
//                       height: 30,
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(color: Colors.transparent, border: Border.all(width: 2, color: value.subscriptionType == 0 ? ProjectColors.themeColorMOD5 : ProjectColors.themeColorMOD5.withAlpha(50)), shape: BoxShape.circle),
//                       child: Container(
//                         decoration: BoxDecoration(shape: BoxShape.circle, color: value.subscriptionType == 0 ? ProjectColors.themeColorMOD5 : ProjectColors.transparent),
//                       ),
//                     ),
//                     Space.spaceWidth(10),
//                     Text('Free membership / 8 hours', maxLines: 1, style: TextStyle(color: value.subscriptionType == 0 ? Colors.white :Colors.white.withAlpha(50), fontSize: SizeConfig.screenWidth! < 350 ? 12 : 14)),
//                   ],
//                 ),
//                 Text('Free', maxLines: 1, style: TextStyle(color: value.subscriptionType == 0 ? Colors.white :Colors.white.withAlpha(50), fontSize: SizeConfig.screenWidth! < 350 ? 13 : 16)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _premiumButton() {
//     return GestureDetector(
//       onTap: () => Provider.of<ModelProvider>(context, listen: false).setSubscriptionType(1),
//       child: Consumer<ModelProvider>(
//         builder: (context, value, child) {
//           return Container(
//             width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
//             height: 50,
//             padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! < 350 ? 10 : 15),
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: value.subscriptionType == 1 ?  ProjectColors.themeColorMOD5 : ProjectColors.themeColorMOD5.withAlpha(50), width: 2),
//             gradient:LinearGradient(colors: [ ProjectColors.themeColorMOD5.withOpacity(0.0),value.subscriptionType == 1 ? ProjectColors.themeColorMOD5.withOpacity(0.4) :Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 30,
//                       height: 30,
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(color: Colors.transparent, border: Border.all(width: 2, color: value.subscriptionType == 1 ? ProjectColors.themeColorMOD5 : ProjectColors.themeColorMOD5.withAlpha(50)), shape: BoxShape.circle),
//                       child: Container(
//                         decoration: BoxDecoration(shape: BoxShape.circle, color: value.subscriptionType == 1 ? ProjectColors.themeColorMOD5 : ProjectColors.transparent),
//                       ),
//                     ),
//                     Space.spaceWidth(10),
//                     Text('Lifetime Premium', maxLines: 1, style: TextStyle(color: value.subscriptionType == 1 ? Colors.white :Colors.white.withAlpha(50), fontSize: SizeConfig.screenWidth! < 350 ? 12 : 14)),
//                   ],
//                 ),
//                 Text(r'$30', maxLines: 1, style: TextStyle(color: value.subscriptionType == 1 ? Colors.white :Colors.white.withAlpha(50), fontSize: SizeConfig.screenWidth! < 350 ? 13 : 16)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   navigateToPayment(){
//     Navigator.push(context, PageRouteBuilder(
//       pageBuilder: ((context, animation, secondaryAnimation) => const Payment(isFreeTrialOver: false)),
//       transitionsBuilder: (context, anim, secondaryAnimation, child) => FadeTransition(opacity: anim, child: child),
//       transitionDuration: const Duration(milliseconds: 500)
//     ));
//   }

//   navigateToHome(){
//     //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
//   }
// }

