import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wseen/helpers/helpers.dart';
import 'package:wseen/models/dialogadd.dart';
import 'package:wseen/models/expiration.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/models/utils.dart';
import 'package:wseen/providers/modelprovider.dart';
import 'package:wseen/services/services.dart';
import '../products/products.dart';

class Monitor extends StatefulWidget {
  const Monitor({Key? key}) : super(key: key);

  @override
  State<Monitor> createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {

  dynamic notificationToken;
  bool? isPremium;

  @override
  void initState() {
    getIsPremium();
    getToken();
    WidgetsBinding.instance.addPostFrameCallback(((timeStamp) {
      getExpDate();
      _getNotificationStatus();
    }));
    FirebaseFirestore.instance.collection('webusers').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'notification_token': notificationToken ?? ''
    });
    super.initState();
    
  }

  getIsPremium() async {
    isPremium = await FirebaseFirestore.instance.collection('webusers').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => value.get('subscription_type') == 'free' ? false : true);
    setState(() {
      
    });
  }

   _getNotificationStatus(){
    bool isNotificationOPEN = stringToBoolean(CookieManager.getCookie('notification') ?? 'true');
    Provider.of<ModelProvider>(context, listen: false).setNotification(isNotificationOPEN);
  }

  getToken() async {
    try{
      final token = await FirebaseMessaging.instance.getToken();
      notificationToken = token;
    } on Exception catch (_){
      return;
    }
  }

  getExpDate() async {
    Stream stream = await expirationDateStream();
    stream.listen((event) { 
      Provider.of<ModelProvider>(context, listen: false).setSubscriptionExpDate(event);
    });
  }

  clearDate(){
    Provider.of<ModelProvider>(context, listen: false).setStartDate(DateTime.now().subtract(const Duration(days: 1)));
    Provider.of<ModelProvider>(context, listen: false).setEndDate(DateTime.now().add(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {  
    Future.delayed(Duration.zero, () => clearDate());
    SizeConfig.init(context);
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      color: const Color.fromARGB(255, 15, 17, 19),
      child: isPremium == null 
      ? Space.emptySpace
      : Consumer<ModelProvider>(
        builder: (context, value, child) {
          return value.subscriptionExpDate == null ? Space.emptySpace
          : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 15, 17, 19),
            body: _body(value)
          );
        } 
      ),
    );
  }

  Widget _body(ModelProvider value) {
    return Column(
      children: [
        const CustomBar(),
        SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 22, 22, 25), Colors.black, Color.fromARGB(255, 15, 17, 19)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            width: SizeConfig.screenWidth!,
            height: SizeConfig.screenHeight! - 60,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAddNumberButton(context),
                _buildContactUser(value),
                Space.expandedSpace(),
                isPremium! ? Space.emptySpace : value.subscriptionExpDate.isNegative ? buildFreeTrialOver() : buildFreeTrialCounter(value, context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactUser(ModelProvider value) {
    return ContactCard(isPremium: isPremium!, isFreeTrialOver: value.subscriptionExpDate.isNegative ? true : false);
  }

  Widget _buildAddNumberButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('webusers').doc(FirebaseAuth.instance.currentUser!.uid).get();
        final int contactCount = documentSnapshot.get('contact_count');
        if(contactCount > 0) {
          Utils.showSnackBar(text: 'You can follow one person at the same time.', color: Colors.red);
          return;
        }
        showDialog(context: context,builder: (BuildContext ctx) => const DialogAdd());
      },
      child: Container(
          width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
          height: Values.addNumberButtonHeight,
          decoration: BoxDecoration(
              color: ProjectColors.themeColorMOD3,
              border: Border.all(color: ProjectColors.themeColorMOD2, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: ProjectColors.customColor,
                size: 20,
              ),
              Space.sWidth,
              ProjectText.rText(text: 'Add a number', fontSize: Values.bigValue, color: ProjectColors.themeColorMOD2),
            ],
          )),
    );
  }

  Widget buildFreeTrialOver(){
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your free trial is over!', style: GoogleFonts.roboto(color: Colors.white, fontSize: SizeConfig.screenWidth! < 350 ? 14 : 16, fontWeight: FontWeight.w200), textAlign: TextAlign.center),
              Space.spaceHeight(20),
              Text('You can follow unlimitedly by upgrading your\n account now.', style: GoogleFonts.roboto(color: Colors.white, fontSize: SizeConfig.screenWidth! < 350 ? 14 : 16, fontWeight: FontWeight.w200), textAlign: TextAlign.center),
              Space.spaceHeight(20),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed('/payment', arguments: true);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: SizeConfig.screenWidth! > 400 ? 360 : SizeConfig.screenWidth! - 40,
                    height: 50,
                    decoration: BoxDecoration(color: ProjectColors.themeColorMOD5, borderRadius: BorderRadius.circular(15)),
                    child: Center(child: Text('Buy Premium', style: GoogleFonts.roboto(fontSize: 18, color: Colors.white))),
                  ),
                ),
              ),
            ],
          ),
    );
  }


}
  
  Widget buildFreeTrialCounter(ModelProvider value, BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${printDuration(value.subscriptionExpDate)} left\nuntil the end of free tracking!', style: GoogleFonts.roboto(color: Colors.white, fontSize: SizeConfig.screenWidth! < 350 ? 14 : 16, fontWeight: FontWeight.w200), textAlign: TextAlign.center),
              Space.spaceHeight(20),
              Text('You can follow unlimitedly by upgrading your\n account now.', style: GoogleFonts.roboto(color: Colors.white, fontSize: SizeConfig.screenWidth! < 350 ? 14 : 16, fontWeight: FontWeight.w200), textAlign: TextAlign.center),
              Space.spaceHeight(20),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed('/payment', arguments: false);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: SizeConfig.screenWidth! > 400 ? 360 : SizeConfig.screenWidth! - 40,
                    height: 50,
                    decoration: BoxDecoration(color: ProjectColors.themeColorMOD5, borderRadius: BorderRadius.circular(15)),
                    child: Center(child: Text('Buy Premium', style: GoogleFonts.roboto(fontSize: 18, color: Colors.white))),
                  ),
                ),
              ),
            ],
          ),
    );
  }
