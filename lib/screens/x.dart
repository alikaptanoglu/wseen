// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:weloggerweb/providers/providers.dart';
// import '../products/products.dart';

// class PaymentSecond extends StatefulWidget {
//   const PaymentSecond({ Key? key }) : super(key: key);

//   @override
//   State<PaymentSecond> createState() => _PaymentSecondState();
// }
// class _PaymentSecondState extends State<PaymentSecond> {

//   int sayac = const Duration(minutes: 15).inSeconds;
//   int dakika = 0; 
//   int saniye = 0;
//   String dakikaStr= '0';
//   String saniyeStr= '0';
//   bool buttonVisible = true;

//   final List<TextEditingController> controllers = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];

//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _surnameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _cardNumberController = TextEditingController();
//   final TextEditingController _cardDateDayController = TextEditingController();
//   final TextEditingController _cardDateYearController = TextEditingController();
//   //final TextEditingController _cardSecurityController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       if(_scrollController.position.pixels.toInt() >= 450){
//         Provider.of<ModelProvider>(context, listen: false).set80FlagHeight();
//       }else{
//         Provider.of<ModelProvider>(context, listen: false).set0FlagHeight();
//       }
//       Provider.of<ModelProvider>(context, listen: false).getFlagPosition(_scrollController.position.pixels.toDouble());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //modelProvider = Provider.of<ModelProvider>(context,listen: true);
//     SizeConfig.init(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         controller: _scrollController,
//         child: Center(
//           child: Stack(
//             children: [
//             Column(
//               children: [
//               Container(
//                 width: 400,
//                 decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.logo.assetImage, fit: BoxFit.cover)),
//                 child: Container(
//                 width: 400,
//                 height: SizeConfig.screenHeight! - SizeConfig.screenHeight!/5,
//                 decoration: BoxDecoration(gradient: ProjectColors.paymentGradient()),
//                 child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.logo.assetImage, fit: BoxFit.cover),border: Border.all(color: Colors.orange, width: 0.5),borderRadius: BorderRadius.circular(15)),
//                   ),
//                 Space.spaceHeight(30),
//                 ProjectText.rText(text: 'Zaman sınırlı satış', fontSize: 25, color: ProjectColors.customColor, fontWeight: FontWeight.w900),
//                 Space.spaceHeight(10),
//                 ProjectText.rText(text: 'Çok geç olmadan anlaşmayı yakalayın', fontSize: 15, color: ProjectColors.customColor, fontWeight: FontWeight.w300),
//                 Space.spaceHeight(20),
//                 _sayac(), 
//                 Space.spaceHeight(20),
//                 _button(),
//                 Space.spaceHeight(20),
//                 const Divider(color: Colors.white,)
//                 ],
//                 ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Container(
//                     color: const Color.fromARGB(255, 21, 21, 29),
//                     width: 400,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Space.spaceHeight(50),
//                         ProjectText.rText(text: "Profilinizin %17'sini\n başarıyla analiz ettik", fontSize: 20, color: ProjectColors.customColor, fontWeight: FontWeight.bold),
//                         Space.spaceHeight(20),
//                         ProjectText.rText(text: "Profilinizin daha doğru ve ayrıntılı analizini\ngörüntülemek için tam analiz alın.", fontSize: 12, color: ProjectColors.greyColor, fontWeight: FontWeight.w300),
//                         Space.spaceHeight(30),
//                         _cards(),
//                         Space.spaceHeight(30),
//                         const Divider(color: Colors.white,),
//                         Space.spaceHeight(50),
//                         ProjectText.rText(text: 'Sınırlı süreli özel teklif', fontSize: 20, color: ProjectColors.customColor, fontWeight: FontWeight.bold),
//                         Space.spaceHeight(20),
//                         ProjectText.rText(text: 'Profilinizi tamamlayın ve bugün değerli bilgiler edinin!', fontSize: 12, color: ProjectColors.customColor, fontWeight: FontWeight.w300),
//                         Space.spaceHeight(50),
//                         _costCard(),
//                         Space.spaceHeight(20),
//                         Visibility(
//                         visible: buttonVisible,
//                         child: GestureDetector(child: button(context, 'Şimdi Al'),
//                           onTap: (){
//                             setState(() => buttonVisible = false);
//                             _scrollController.animateTo(1650,duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
//                           })),
//                          Visibility(
//                           visible: !buttonVisible,
//                           child: Column(
//                             children: [
//                               TextField(
//                                 controller: _nameController,
//                                 style: const TextStyle(color: Colors.white, fontSize: 15),
//                                 decoration: InputDecoration(
//                                   hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
//                                   contentPadding: const EdgeInsets.all(20.0),
//                                   hintText: 'İlk Ad',
//                                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width: 2),),
//                                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey, width: 1,),),
//                                 ),
//                                 ),
//                                 Space.spaceHeight(20),
//                                 TextField(
//                                 controller: _surnameController,
//                                 style: const TextStyle(color: Colors.white, fontSize: 15),
//                                 decoration: InputDecoration(
//                                   hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
//                                   contentPadding: const EdgeInsets.all(20.0),
//                                   hintText: 'Soy Ad',
//                                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width: 2),),
//                                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey, width: 1,),),
//                                 ),
//                                 ),
//                                 Space.spaceHeight(20),
//                                 TextField(
//                                 controller: _emailController,
//                                 style: const TextStyle(color: Colors.white, fontSize: 15),
//                                 decoration: InputDecoration(
//                                   hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
//                                   contentPadding: const EdgeInsets.all(20.0),
//                                   hintText: 'E-posta',
//                                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width: 2),),
//                                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey, width: 1,),),
//                                 ),
//                                 ),
//                                 Space.spaceHeight(20),
//                                 SizedBox(
//                                   width: SizeConfig.screenWidth!,
//                                   height: 250,
//                                   child: Card(
//                                     color: const Color.fromARGB(255, 31,33,46),
//                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           ProjectText.rText(text: 'CREDIT CARD', fontSize: 20, color: ProjectColors.customColor, fontWeight: FontWeight.bold),
//                                           TextField(
//                                 controller: _cardNumberController,
//                                 style: const TextStyle(color: Colors.white, fontSize: 15),
//                                 decoration: InputDecoration(
//                                   hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
//                                   contentPadding: const EdgeInsets.all(20.0),
//                                   hintText: 'XXXX XXXX XXXX XXXX',
//                                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width: 2),),
//                                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey, width: 1,),),
//                                 ),
//                                 ),
//                                 Row(
//                                   children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: TextField(
//                                                                         controller: _cardDateDayController,
//                                                                         style: const TextStyle(color: Colors.white, fontSize: 15),
//                                                                         decoration: InputDecoration(
//                                                                           hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
//                                                                           contentPadding: const EdgeInsets.all(20.0),
//                                                                           hintText: 'MM',
//                                                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width: 2),),
//                                                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey, width: 1,),),
//                                                                         ),
//                                                                         ),
//                                             ),
//                                                                   Space.spaceWidth(5),
//                                                                   Expanded(
//                                                                     child: TextField(
//                                                                     controller: _cardDateYearController,
//                                                                     style: const TextStyle(color: Colors.white, fontSize: 15),
//                                                                     decoration: InputDecoration(
//                                                                       hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
//                                                                       contentPadding: const EdgeInsets.all(20.0),
//                                                                       hintText: 'YY',
//                                                                       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width: 2),),
//                                                                       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey, width: 1,),),
//                                                                     ),
//                                                                     ),
//                                                                   ),
//                                         ],),
//                                       ),
//                                       Space.spaceWidth(20),
//                                       Expanded(
//                                         flex: 1,
//                                         child: TextField(
//                                                                       controller: _cardDateYearController,
//                                                                       style: const TextStyle(color: Colors.white, fontSize: 15),
//                                                                       decoration: InputDecoration(
//                                                                         hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
//                                                                         contentPadding: const EdgeInsets.all(20.0),
//                                                                         hintText: 'Code',
//                                                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width: 2),),
//                                                                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey, width: 1,),),
//                                                                       ),
//                                                                       ),
//                                       ),
//                                   ],
//                                 )
//                                       ],),
//                                     )
//                                   ),
//                                 ),
//                                 Space.spaceHeight(20),
//                                 //button(60,'Kredi kartını işle', Container(), Container(), Colors.grey.withAlpha(120), const Color.fromARGB(255, 31,33,46).withAlpha(120), context),
//                             ],
//                           ),
//                         ),
//                         Space.spaceHeight(50),
//                         const Divider(color: Colors.white,),
//                         Space.spaceHeight(50),
//                         ProjectText().linkText('Gizlilik Politikası', const Color.fromARGB(255, 111, 113, 225), FontWeight.w300, const Color.fromARGB(255, 111, 113, 225)),
//                         Space.spaceHeight(10),
//                         ProjectText().linkText('Kullanım Şartları', const Color.fromARGB(255, 111, 113, 225), FontWeight.w300, const Color.fromARGB(255, 111, 113, 225)),
//                         Space.spaceHeight(20),
//                         ProjectText.rText(text: 'Bir sorunuz mu var? Dost canlısı destek ekibimize', fontSize: 12, color: ProjectColors.greyColor, fontWeight: FontWeight.w300),
//                         ProjectText().linkText('buradan ulaşın', const Color.fromARGB(255, 111, 113, 225), FontWeight.w300, const Color.fromARGB(255, 111, 113, 225)),
//                         Space.spaceHeight(20),
//                         ProjectText.rText(text: 'Huracanapps 15 Cuttermill rd,', fontSize: 12, color: ProjectColors.greyColor, fontWeight: FontWeight.w300),
//                         ProjectText.rText(text: 'Unit 545 Great Neck, NY', fontSize: 12, color: ProjectColors.greyColor, fontWeight: FontWeight.w300),
//                         ProjectText.rText(text: '11021 +13072139072', fontSize: 12, color: ProjectColors.greyColor, fontWeight: FontWeight.w300),
//                         ProjectText().linkText('suppor@huracanapps.com', const Color.fromARGB(255, 111, 113, 225), FontWeight.w300, const Color.fromARGB(255, 111, 113, 225)),
//                         Space.spaceHeight(50),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               ]
//             ),
//             Consumer<ModelProvider>(
//               builder:(_, value, __) {
//                 return AnimatedPositioned(
//                 duration: const Duration(milliseconds: 100),
//                 top:  value.flagPosition,
//                 child: AnimatedContainer(
//                 width: 400,
//                 height: value.flagHeight,
//                 color: const Color.fromARGB(255, 255, 54, 94),
//                 duration: const Duration(milliseconds: 500),child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                   const Text('Kişiselleştirilmiş planınız önümüzdeki 15 dakika \niçin rezerve edildi!', style: TextStyle(color: Colors.white, fontSize: 12),),
//                   Text(dakika < 10 && saniye <10 ? '00 : 0$dakikaStr : 0$saniyeStr' : dakika >= 10 && saniye <10 ?  '00 : $dakikaStr : 0$saniyeStr' : dakika <10 && saniye >=10 ? '00 : 0$dakikaStr : $saniyeStr' : '00 : $dakikaStr : $saniyeStr', style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w900),),
//                   ])),
//                 );
//               },
              
//             ),
            
//             ]
//           ),
//         ),
//       ),
//     );
//   }

//   Container button(BuildContext context, String text) {
//     return Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.pink),
//                         width: MediaQuery.of(context).size.width,
//                         height: 60,
//                         child: Center(child: Text(text,style: TextStyle(color: ProjectColors.customColor, decoration: TextDecoration.none,fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center)));
//   }

//   SizedBox _costCard() {
//     return SizedBox(
//                   width: SizeConfig.screenWidth!,
//                   height: 300,
//                   child: Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                     color: Colors.black12,
//                     child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                     Container(
//                       width: SizeConfig.screenWidth!,
//                       height: 190,
//                       decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.webbackgroundimage.assetImage, fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop)),borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 15) + const EdgeInsets.symmetric(vertical: 5),
//                             color: const Color.fromARGB(255, 255, 54, 94),
//                             child: const Text('ÖZEL TEKLİF', style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 2,fontWeight: FontWeight.bold),)
//                           ),
//                           const Text('%90', style: TextStyle(color: Colors.white, fontSize: 100,fontWeight: FontWeight.w700, ))
//                         ],
//                       ),
//                     ),
//                     Container(
//                       decoration: const BoxDecoration(color:  Color.fromARGB(255, 31,33,46),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         children: [
//                           Space.spaceHeight(20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                             ProjectText.rText(text: '7 Günlük Deneme', fontSize: 15, color: ProjectColors.customColor,fontWeight: FontWeight.w300),
                            
//                             Row(
//                               children: [
//                                 const Text(r'$9.99', style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), decoration:TextDecoration.lineThrough,decorationThickness: 2,decorationColor: Color.fromARGB(255, 255, 0, 0),fontSize: 15,fontWeight: FontWeight.w900),),
//                                 Space.spaceWidth(5),
//                                 ProjectText.rText(text: r'1.00$', fontSize: 15, color: ProjectColors.customColor,fontWeight: FontWeight.w300),
//                               ],
//                             ),
//                           ],),
//                       Space.spaceHeight(5),
//                       const Divider(color: Colors.white),
//                       Space.spaceHeight(5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ProjectText.rText(text: 'Toplam Bugün', fontSize: 15, color: ProjectColors.customColor,fontWeight: FontWeight.w900),
//                           ProjectText.rText(text: r'1.00$', fontSize: 15, color: ProjectColors.customColor,fontWeight: FontWeight.w900),
//                       ],),
//                       Space.spaceHeight(20),
//                         ],
//                       ),
//                     ),
                    
//                     ]),),
//                 );
//   }
  
//   StreamBuilder<dynamic> _sayac() {
//     return StreamBuilder(
//           stream: Stream.periodic(const Duration(seconds: 1)),
//           builder: (context, snapshot){
//             sayac-=1;
//             dakika = sayac~/60;
//             saniye = sayac%60;

//             dakikaStr = dakika.toString();
//             saniyeStr = saniye.toString();
//             return _sayacRow();
//           },);
//   }

//   Widget _sayacRow() {
//     return Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: [
//                   ProjectText.rText(text: '00', fontSize: 30, color: ProjectColors.customColor,fontWeight: FontWeight.w900),
//                   Space.spaceHeight(5),
//                   ProjectText.rText(text: 'saat', fontSize: 10, color: ProjectColors.customColor,fontWeight: FontWeight.w300),
//                 ],
//               ),
//               ProjectText.rText(text: ':        ', fontSize: 30, color: ProjectColors.customColor,fontWeight: FontWeight.w900),
//               Column(
//                 children: [
//                   ProjectText.rText(text: dakika < 10 ? '0$dakikaStr' : dakikaStr, fontSize: 30, color: ProjectColors.customColor,fontWeight: FontWeight.w900),
//                   Space.spaceHeight(5),
//                   ProjectText.rText(text: 'dakika', fontSize: 10,color: ProjectColors.customColor,fontWeight: FontWeight.w300),
//                 ],
//               ),
//               ProjectText.rText(text: ':        ', fontSize: 30, color: ProjectColors.customColor,fontWeight: FontWeight.w900),
//               Column(
//                 children: [
//                   ProjectText.rText(text: saniye < 10 ? '0$saniyeStr' : saniyeStr, fontSize: 30, color: ProjectColors.customColor,fontWeight: FontWeight.w900),
//                   Space.spaceHeight(5),
//                   ProjectText.rText(text: 'saniye', fontSize: 10,color: ProjectColors.customColor,fontWeight: FontWeight.w300),
//                 ],
//               ),
//             ],
//           );
//   }

//   GestureDetector _button() {
//     return GestureDetector(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: button(context, "Welogger'ı edinin"),
//             ),
//             onTap: (){
//               if(buttonVisible){
//                 _scrollController.animateTo(1160,duration: const Duration(seconds: 1), curve: Curves.easeIn);
//               }else{_scrollController.animateTo(1650,duration: const Duration(seconds: 1), curve: Curves.easeIn);}
//             }
//           );
//   }

//   Column _cards() {
//     return Column(
//                   children: [
//                 _cardRow(FontAwesomeIcons.hatWizard, 'Gizli hayranlar', FontAwesomeIcons.circle, 'Seni engelledi',10),
//                 Space.spaceHeight(10),
//                 _cardRow(FontAwesomeIcons.heart, 'En çok beğenenler', FontAwesomeIcons.heartCrack, 'Silinen beğeniler',10),
//                 Space.spaceHeight(10),
//                 _cardRow(Icons.person_add, 'Yeni takipçiler', Icons.person_remove_rounded, 'Kayıp takipçiler',10),
//                 Space.spaceHeight(10),
//                 _cardRow(FontAwesomeIcons.message, 'En iyi yorumlar', FontAwesomeIcons.circle, 'Silinen yorumlar',10),
//                   ],
//                 );
//   }

//   Row _cardRow(IconData cardFirstIcon, String cardFirstText,IconData cardSecondIcon, String cardSecondText, double radius) {
//     return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.only(right: 5),
//                       height: 120,
//                       child: Card(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius),),
//                         color: const Color.fromARGB(255, 31,33,46),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                           Icon(cardFirstIcon, size: 40, color: const Color.fromARGB(255, 107, 109, 255)),
//                           ProjectText.rText(text: cardFirstText, fontSize: 10, color: ProjectColors.customColor, fontWeight: FontWeight.w300)
//                         ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.only(left: 5),
//                       height: 120,
//                       child: Card(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius),),
//                         color: const Color.fromARGB(255, 31,33,46),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                           Icon(cardSecondIcon, size: 40, color: const Color.fromARGB(255, 107, 109, 255)),
//                           ProjectText.rText(text: cardSecondText, fontSize: 10, color: ProjectColors.customColor, fontWeight: FontWeight.w300),
//                         ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],);
//   }
// }
