import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wseen/helpers/helpers.dart';
import 'package:wseen/models/bar.dart';
import 'package:wseen/models/endsection.dart';
import 'package:wseen/models/floatingactionbutton.dart';
import 'package:wseen/models/loading.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';
import 'package:wseen/services/cookie.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  bool? isLogin;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if(!mounted) return;
    _getUserCookies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {    
      Provider.of<ModelProvider>(context, listen: false).setAnimatedFloatButtonPositionedValue(0);
    });
    Future.delayed(const Duration(milliseconds: 500),(){
      Provider.of<ModelProvider>(context, listen: false).setMainAnimatedTopPositionedValue(0);
    });
    scrollController.addListener((){
      Provider.of<ModelProvider>(context, listen: false).setMainScrollPixel(scrollController.position.pixels);
      if(scrollController.position.pixels > 1000){
        Provider.of<ModelProvider>(context, listen: false).setAnimatedFloatButtonPositionedValue(30);
      }else{
        Provider.of<ModelProvider>(context, listen: false).setAnimatedFloatButtonPositionedValue(0);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


   _getUserCookies(){
    Map? cookieMap = CookieManager.getCookieAsMap();
    isLogin = stringToBoolean(cookieMap!['login'] ?? '');
    if(isLogin!){
      String email = cookieMap['email'];
      String password = cookieMap['password'];
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => Navigator.of(context).pushNamedAndRemoveUntil('/monitor', (route) => false));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return isLogin == null || isLogin! ? const LoadingThreeDots() : body();
  }

  Scaffold body() {
    return Scaffold(
    backgroundColor: const Color.fromARGB(255, 15, 17, 19),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: Stack(
      children: [
        ActionButton(scrollController: scrollController)
      ],
    ),
    body: Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            width: SizeConfig.screenWidth!,
            height: 1200,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/ic_mainbackground.png'), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black26, BlendMode.dstIn))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                buildSection1(),
                buildSection2(),
                buildSection3(),
                buildSection4(),
                const EndSection()
              ],
            ),
          ),
        ),
        MainBar(isTransparent: true, isMainPage: true, scrollController: scrollController),
        const LoadingTick()
      ],
    ),
  );
  }


  Widget buildSection4(){

    List<Widget> helpersSingle = [
      _helpers1(),
      Space.spaceHeight(20),
      _helpers2(),
      Space.spaceHeight(20),
      _helpers3(),
      Space.spaceHeight(20),
      _helpers4(),
      Space.spaceHeight(20),  
    ];

  List<Widget> helpersTwo = [
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _helpers1(),  
        Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/3),
        _helpers2(),
      ],
    ),
    Space.spaceHeight(60),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _helpers3(),
        Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/3),
        _helpers4()
      ],
    ),
  ];

  List<Widget> helpersAll = [
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _helpers1(),
        Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/5),
        _helpers2(),
        Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/5),
        _helpers3(),
        Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/5),
        _helpers4(),
      ],
    ),  
  ];
    return Container(
      width: SizeConfig.screenWidth,
      color: ProjectColors.themeColorMOD5,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * 0.25 : SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * 0.2 : SizeConfig.screenWidth! > 600 ? SizeConfig.screenWidth! * 0.15 : 50),
            child: Column(
              children: [
                Space.spaceHeight(100),
                Text('What Wseen can help you with', style: GoogleFonts.nunito(fontSize: SizeConfig.screenWidth! < 400 ? 30 : SizeConfig.screenWidth! < 600 ? 35 : SizeConfig.screenWidth! < 800 ? 40 : SizeConfig.screenWidth! < 1200 ? 45 : 50, color: Colors.white, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
                Space.spaceHeight(40),
                Text('Our Whatsapp online checker and tracker has plenty of potential uses. Think tracking teenagers who are staying up all night to chat before a big test, coworkers who are spending more time on Whatsapp than they should, or even family members and friends who are up to something suspicious. If you desperately need to know, we’re here to help.', style: GoogleFonts.nunito(fontSize: SizeConfig.screenWidth! < 350 ? 18 : SizeConfig.screenWidth! < 400 ? 20 : SizeConfig.screenWidth! < 600 ? 22 : SizeConfig.screenWidth! < 800 ? 24 : SizeConfig.screenWidth! < 1200 ? 25 : 25, color: Colors.white60, height: 1.5), textAlign: TextAlign.center,),
                Space.spaceHeight(60),
                Space.dividerHorizantal(width: SizeConfig.screenWidth! < 400 ? 200 : 300, height: 1, color: Colors.white10),
                Space.spaceHeight(60),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! > 1200 ? (SizeConfig.screenWidth! * 0.2)/5 : SizeConfig.screenWidth! > 800 ? (SizeConfig.screenWidth! * 0.2)/3 : 0),
            child: Column(children: SizeConfig.screenWidth! > 1200 ? helpersAll : SizeConfig.screenWidth! > 800 ? helpersTwo : helpersSingle),
          ),
          Space.spaceHeight(60),
        ],
      ),
    );
  }

  Widget buildSection3() {
    return Container(
      width: SizeConfig.screenWidth,
      color: const Color.fromARGB(255, 230, 230, 230),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! < 800 ? 40 : SizeConfig.screenWidth! < 600 ? 20 : SizeConfig.screenWidth! < 400 ? 20 : 10),
            child: Column(
              children: [
                Space.spaceHeight(100),
                ProjectText.rText(text: 'Features', fontSize: SizeConfig.screenWidth! < 600 ? 40 : SizeConfig.screenWidth! < 400 ? 35 : 50, color: Colors.black, letterSpacing: 2, fontWeight: FontWeight.w800),
                Space.spaceHeight(40),
                ProjectText.rText(text: 'Wseen is loaded with features you will absolutely love.', fontSize: SizeConfig.screenWidth! < 600 ? 22 : SizeConfig.screenWidth! < 400 ? 20 : 25, color: Colors.black45, letterSpacing: 1, fontWeight: FontWeight.w400),
                Space.spaceHeight(60),
                Space.dividerHorizantal(width: SizeConfig.screenWidth! < 400 ? 200 : 300, height: 1, color: Colors.black12),
                Space.spaceHeight(80),
              ],
            ),
          ),
          Wrap(
            direction: SizeConfig.screenWidth! > 700 ? Axis.horizontal : Axis.vertical,
            children: [
              buildFeatures(header: 'Notifications', text1: 'Get notified when anyone of your friends gets online on Whatsapp!', text2: 'They haven’t replied to your messages? Get notified when they’re online!', text3: 'Did they login at 3am? Are they up yet? Get notified and stay in the know!', icon: Icons.notifications_outlined),
              SizeConfig.screenWidth! > 1200 ? Space.spaceWidth(SizeConfig.screenWidth! * .1) : SizeConfig.screenWidth! > 700 ? Space.spaceWidth(SizeConfig.blockSizeHorizontal! * 10) : Space.spaceHeight(60),
              buildFeatures(header: 'Online History', text1: 'How much time do they spend chatting on Whatsapp?', text2: 'Scroll through a comprehensive timeline to track last seen on Whatsapp and see exactly when they were online at any given time.', icon: FontAwesomeIcons.clock),
            ],
          ),
          Space.spaceHeight(80),
          eightHourButton(),
          Space.spaceHeight(100),
        ],
      ),
    );
  }

  Widget buildSection2() {

    List<Widget> carouselSliderItems = [
    Column(
      children: [
        RichText(text: TextSpan(text: '“ ',style: GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: SizeConfig.screenWidth! < 500 ? 20 : SizeConfig.screenWidth! < 600 ? 25 : 30), children: [TextSpan(text: 'A new app called Wseen uses information from WhatsApp to track friend activity and estimate things like when they go to bed or who they were most likely talking to.', style: GoogleFonts.nunito(height: SizeConfig.screenWidth! < 500 ? 1.3 : 1.5, fontStyle: FontStyle.italic, color: Colors.grey, fontSize: SizeConfig.screenWidth! < 500 ? 16 : SizeConfig.screenWidth! < 600 ? 20 : 25, fontWeight: FontWeight.w100)), TextSpan(text: ' ”', style: GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: SizeConfig.screenWidth! < 500 ? 20 : SizeConfig.screenWidth! < 600 ? 25 : 30))])),
        Space.spaceHeight(SizeConfig.screenWidth! > 600 ? 20 : 10),
        Align(alignment: Alignment.centerLeft, child: Text('-Jacob Kleinman', style: GoogleFonts.nunito(color: Colors.black54, fontSize: SizeConfig.screenWidth! < 400 ? 8 : SizeConfig.screenWidth! < 500 ? 10 : 12, fontWeight: FontWeight.w200)))
      ],
    ),
    Column(
      children: [
        RichText(text: TextSpan(text: '“ ',style: GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: SizeConfig.screenWidth! < 500 ? 20 : SizeConfig.screenWidth! < 600 ? 25 : 30), children: [TextSpan(text: 'WhatsApp which swears by its end-to-end encryption for chats may not be as safe as it claims to be. A new app called "Wseen" lets users creepily spy on their friends on WhatsApp.', style: GoogleFonts.nunito(height: SizeConfig.screenWidth! < 500 ? 1.3 : 1.5, fontStyle: FontStyle.italic, color: Colors.grey, fontSize: SizeConfig.screenWidth! < 500 ? 16 : SizeConfig.screenWidth! < 600 ? 20 : 25, fontWeight: FontWeight.w100)), TextSpan(text: ' ”', style: GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: SizeConfig.screenWidth! < 500 ? 20 : SizeConfig.screenWidth! < 600 ? 25 : 30))])),
        Space.spaceHeight(SizeConfig.screenWidth! > 600 ? 20 : 10),
        Align(alignment: Alignment.centerLeft, child: Text('-Jacob Kleinman', style: GoogleFonts.nunito(color: Colors.black54, fontSize: SizeConfig.screenWidth! < 400 ? 8 : SizeConfig.screenWidth! < 500 ? 10 : 12, fontWeight: FontWeight.w200)))
      ],
    ),
    Column(
      children: [
        RichText(text: TextSpan(text: '“ ',style: GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: SizeConfig.screenWidth! < 500 ? 20 : SizeConfig.screenWidth! < 600 ? 25 : 30), children: [TextSpan(text: 'The creepy banned mobile app that lets users spy on Whatsapp contacts now has a web version. If you thought you were safe after Wseen was pulled from both the App Store and Google Play, think again.', style: GoogleFonts.nunito(height: SizeConfig.screenWidth! < 500 ? 1.3 : 1.5, fontStyle: FontStyle.italic, color: Colors.grey, fontSize: SizeConfig.screenWidth! < 500 ? 16 : SizeConfig.screenWidth! < 600 ? 20 : 25, fontWeight: FontWeight.w100)), TextSpan(text: ' ”', style: GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: SizeConfig.screenWidth! < 500 ? 20 : SizeConfig.screenWidth! < 600 ? 25 : 30))])),
        Space.spaceHeight(SizeConfig.screenWidth! > 600 ? 20 : 10),
        Align(alignment: Alignment.centerLeft, child: Text('-Jacob Kleinman', style: GoogleFonts.nunito(color: Colors.black54, fontSize: SizeConfig.screenWidth! < 400 ? 8 : SizeConfig.screenWidth! < 500 ? 10 : 12, fontWeight: FontWeight.w200)))
      ],
    ),
    Column(
      children: [
        RichText(text: TextSpan(text: '“ ',style: GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: SizeConfig.screenWidth! < 500 ? 20 : SizeConfig.screenWidth! < 600 ? 25 : 30), children: [TextSpan(text: 'Facebook spies on us all the time, and, by extension, so do the companies it owns like Instagram and WhatsApp. Now, one app is turning the tables by letting you use all that data they’re quietly collecting to spy on your own WhatsApp friends and contacts.', style: GoogleFonts.nunito(height: SizeConfig.screenWidth! < 500 ? 1.3 : 1.5, fontStyle: FontStyle.italic, color: Colors.grey, fontSize: SizeConfig.screenWidth! < 500 ? 16 : SizeConfig.screenWidth! < 600 ? 20 : 25, fontWeight: FontWeight.w100)), TextSpan(text: ' ”', style: GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: SizeConfig.screenWidth! < 500 ? 20 : SizeConfig.screenWidth! < 600 ? 25 : 30))])),
        Space.spaceHeight(SizeConfig.screenWidth! > 600 ? 20 : 10),
        Align(alignment: Alignment.centerLeft, child: Text('-Jacob Kleinman', style: GoogleFonts.nunito(color: Colors.black54, fontSize: SizeConfig.screenWidth! < 400 ? 8 : SizeConfig.screenWidth! < 500 ? 10 : 12, fontWeight: FontWeight.w200)))
        ],
      ),
    ];
    return Container(
      width: SizeConfig.screenWidth,
      color: const Color.fromARGB(255, 240, 240, 240),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! < 800 ? 40 : SizeConfig.screenWidth! < 600 ? 20 : SizeConfig.screenWidth! < 400 ? 20 : 10),
      child: Column(
        children: [
          Space.spaceHeight(100),
          ProjectText.rText(text: 'As seen on the Press', fontSize: SizeConfig.screenWidth! > 800 ? 40 : SizeConfig.screenWidth! > 600 ? 38 : SizeConfig.screenWidth! > 500 ? 36 : SizeConfig.screenWidth! > 400 ? 34 : SizeConfig.screenWidth! > 350 ? 32 : 30, color: Colors.black, fontWeight: FontWeight.w800),
          Space.spaceHeight(60),
          SizedBox(
            width: SizeConfig.screenWidth! > 700 ? 600 : SizeConfig.screenWidth! > 500 ? SizeConfig.screenWidth! - 80 : SizeConfig.screenWidth! - 40,
            child: CarouselSlider(
              items: carouselSliderItems, 
              options: CarouselOptions(
                height: SizeConfig.screenWidth! < 400 && SizeConfig.screenWidth! > 350 ? 250 : SizeConfig.screenWidth! < 600 ? 250 : 300,
                onPageChanged: (index, reason) {
                  Provider.of<ModelProvider>(context, listen: false).setIndicatorIndex(index);
                },
                scrollPhysics: const NeverScrollableScrollPhysics(),
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
            ),
          ),
          Consumer<ModelProvider>(
            builder:(context, value, child) => AnimatedSmoothIndicator(activeIndex: value.indicatorIndex, count: 4),
          ),
          Space.spaceHeight(100),
        ],
      ),
    );
  }

  Widget buildSection1() {
    return Consumer<ModelProvider>(
      builder: (context, value, child) {
        return Stack(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1500),
              opacity: value.mainAnimatedTopPositionedValue == 0 ? 1 : 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                width: SizeConfig.screenWidth,
                curve: Curves.fastOutSlowIn,
                padding: EdgeInsets.only(top: value.mainAnimatedTopPositionedValue, left: SizeConfig.screenWidth! > 1300 ? 60 + SizeConfig.screenWidth! * .06 : SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * .08 : 0) + EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! > 1200 ? 0 : SizeConfig.screenWidth! > 600 ? 40 : SizeConfig.screenHeight! > 400 ? 20 : SizeConfig.screenWidth! > 300 ? 15 : 10),
                color: Colors.transparent,
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  direction: SizeConfig.screenWidth! > 1200 ? Axis.horizontal : Axis.vertical,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: SizeConfig.screenWidth! > 1200 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        Space.spaceHeight(60),
                        thick(),
                        ProjectText.rText(text: 'The original\nWhatsapp Online\nTracker', fontSize: SizeConfig.screenWidth! < 300 ? 30 : SizeConfig.screenWidth! < 400 ? 35 : SizeConfig.screenWidth! < 500 ? 40 : SizeConfig.screenWidth! < 600 ? 50 : SizeConfig.screenWidth! < 800 ? 55 : SizeConfig.screenWidth! > 1200 ? 60 : 70, color: Colors.white, fontWeight: FontWeight.w800, textAlign: SizeConfig.screenWidth! > 1200 ? TextAlign.left : TextAlign.center),
                        Space.spaceHeight(35),
                        SizedBox(width: SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * .5 : SizeConfig.screenWidth! * 0.8, child: ProjectText.rText(text: '“Who were you chatting with at 3am?”', fontSize: SizeConfig.screenWidth! < 300 ? 20 : SizeConfig.screenWidth! < 400 ? 25 : SizeConfig.screenWidth! < 500 ? 28 : SizeConfig.screenWidth! < 600 ? 30 : SizeConfig.screenWidth! < 800 ? 35 : SizeConfig.screenWidth! > 1200 ? 40 : 45, color: Colors.white, fontWeight: FontWeight.w800, textAlign: SizeConfig.screenWidth! > 1200 ? TextAlign.left : TextAlign.center)),
                        Space.spaceHeight(25),
                        SizedBox(width: SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * .5 : SizeConfig.screenWidth! * 0.8,child: Text("Wseen is here to answer that age old question. Use Wseen to monitor your friends, family or employee's Whatsapp usage. Find out when they went to bed and woke up, using\n Artificial Intelligence.\nYep, we made it happen.", style: GoogleFonts.nunito(height: 2, fontSize: SizeConfig.screenWidth! < 300 ? 14 : SizeConfig.screenWidth! < 400 ? 16 : SizeConfig.screenWidth! < 600 ? 18 : SizeConfig.screenWidth! < 800 ? 20 : 22, color: const Color.fromARGB(255, 180, 180, 180), fontWeight: FontWeight.w300), textAlign: SizeConfig.screenWidth! > 1200 ? TextAlign.left : TextAlign.center)),
                        Space.spaceHeight(30),
                        eightHourButton(),
                        Space.spaceHeight(SizeConfig.screenWidth! < 600 ? 200 : SizeConfig.screenWidth! < 1200 ? 400 : 80),  
                      ],
                    ),
                    SizeConfig.screenWidth! > 1200 ? Space.spaceWidth(40) : Space.spaceHeight(SizeConfig.screenWidth! > 600 ? 70 : 80),
                    SizeConfig.screenWidth! > 1200 
                    ? Column(
                      children: [
                        Space.spaceHeight(140),
                        const SizedBox(
                          width: 375,
                          child: Image(image: AssetImage('assets/images/ic_notificationscreenshot.png'))),
                      ])
                    : Space.emptySpace
                  ],
                ),
              ),
            ),
            Visibility(
              visible: SizeConfig.screenWidth! > 1200 ? false : true,
              child: Positioned(
                bottom: SizeConfig.screenWidth! > 600 ? -180 : -100,
                left: (SizeConfig.screenWidth! - (SizeConfig.screenWidth! > 600 ? 350 : 200)) * .5,
                child: Image(image: const AssetImage('assets/images/ic_notificationscreenshot.png'), width: SizeConfig.screenWidth! > 600 ? 350 : 200)),
            )
          ],
        );
      },
    );
  }

  Widget thick() {
    return Visibility(
      visible: SizeConfig.screenWidth! > 1200 ? true : false,
      child: Column(
        children: [
          Container(width: 80, height: 2, decoration: BoxDecoration(borderRadius: BorderRadius.circular(1),  color: ProjectColors.themeColorMOD5)),
          Space.spaceHeight(30),
        ],
      ),
    );
  }

  Widget eightHourButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/sign'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: SizeConfig.screenWidth! < 400 ? SizeConfig.screenWidth! - 80 : SizeConfig.screenWidth! < 500 ? SizeConfig.screenWidth! - 120 : 360,
          height: SizeConfig.screenWidth! < 500 ? 50 : 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: ProjectColors.themeColorMOD5, borderRadius: BorderRadius.circular(10)),
          child: Center(child: FittedBox(child: Text('8 - Hour Free Trial', style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, letterSpacing: 2)))),
        ),
      ),
    );
  }

  Widget buildFeatures({required String header, required String text1, required String text2, required IconData icon, String? text3}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * 0.3 : SizeConfig.screenWidth! > 700 ? (SizeConfig.screenWidth! * 0.7)/2 : SizeConfig.screenWidth! > 500 ? SizeConfig.screenWidth! - 160 : SizeConfig.screenWidth! > 400 ? SizeConfig.screenWidth! - 80 : SizeConfig.screenWidth! > 300 ? SizeConfig.screenWidth! - 60 : SizeConfig.screenWidth! - 40, 
          child: Column(
            crossAxisAlignment: SizeConfig.screenWidth! > 700 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: ProjectColors.themeColorMOD5, size: 60),
              Space.spaceHeight(20),
              ProjectText.rText(text: header, fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black, textAlign: SizeConfig.screenWidth! > 700 ? TextAlign.left : TextAlign.center),
              Space.spaceHeight(20),
              SizedBox(
                height: SizeConfig.screenWidth! <= 700 ? text3 == null ? 250 : 300 : 350,
                child: Column(
                  children: [
                    SizedBox(child: Text(text1, style: GoogleFonts.nunito(height: 1.5, color: const Color.fromARGB(255, 40, 40, 40), fontSize: 18, fontWeight: FontWeight.w300), textAlign: SizeConfig.screenWidth! > 700 ? TextAlign.left : TextAlign.center)),
                    Space.spaceHeight(40),
                    SizedBox(child: Text(text2, style: GoogleFonts.nunito(height: 1.5, color: const Color.fromARGB(255, 40, 40, 40), fontSize: 18, fontWeight: FontWeight.w300), textAlign: SizeConfig.screenWidth! > 700 ? TextAlign.left : TextAlign.center)),
                    text3 == null
                    ? Space.emptySpace
                    : Column(
                      children: [
                        Space.spaceHeight(40),
                        SizedBox(child: Text(text3, style: GoogleFonts.nunito(height: 1.5, color: const Color.fromARGB(255, 40, 40, 40), fontSize: 18, fontWeight: FontWeight.w300), textAlign: SizeConfig.screenWidth! > 700 ? TextAlign.left : TextAlign.center)),
                      ],
                    ),
                    //Space.expandedSpace(),
                  ],
                ),
              ),
              //Padding(padding: EdgeInsets.only(left: SizeConfig.screenWidth! > 700 ? 0 : 20, right: 20), child: const Image(image: AssetImage('assets/images/ic_back.png')))
            ],
          ),
        ),
      ],
    );
  }  



   Widget _helpers4() {
    return SizedBox(
       width: SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * 0.2 : SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * 0.4 : SizeConfig.screenWidth! > 600 ? SizeConfig.screenWidth! - 120 : SizeConfig.screenWidth! > 400 ? SizeConfig.screenWidth! - 60 : SizeConfig.screenWidth! > 300 ? SizeConfig.screenWidth! - 40 : SizeConfig.screenWidth! - 20,
      child: Column(
        crossAxisAlignment: SizeConfig.screenWidth! > 800 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text('Impressive functionality', style: GoogleFonts.roboto(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, height: 1.5), textAlign: SizeConfig.screenWidth! > 800 ? TextAlign.left : TextAlign.center),
          Space.spaceHeight(20),
          RichText(textAlign: SizeConfig.screenWidth! > 800 ? TextAlign.left : TextAlign.center, text: TextSpan(text: '•  ', style: GoogleFonts.nunito(height: 1.5, color: const Color.fromARGB(255, 240, 240, 240), fontSize: 18, fontWeight: FontWeight.bold), children: const [TextSpan(text: 'Track online history: ', style: TextStyle(height: 1.5, color: Color.fromARGB(255, 240, 240, 240), fontSize: 16, fontWeight: FontWeight.bold)), TextSpan(text: 'Find out exactly how much time they spend chatting on Whatsapp.', style: TextStyle(height: 1.5, color: Color.fromARGB(255, 240, 240, 240), fontSize: 16))])),
          Space.spaceHeight(10),
          RichText(textAlign: SizeConfig.screenWidth! > 800 ? TextAlign.left : TextAlign.center, text: TextSpan(text: '•  ', style: GoogleFonts.nunito(height: 1.5, color: const Color.fromARGB(255, 240, 240, 240), fontSize: 18, fontWeight: FontWeight.bold), children: const [TextSpan(text: 'Get online notifications: ', style: TextStyle(height: 1.5, color: Color.fromARGB(255, 240, 240, 240), fontSize: 16, fontWeight: FontWeight.bold)), TextSpan(text: 'check when someone connects on Whatsapp and be notified in realtime about it.', style: TextStyle(height: 1.5, color: Color.fromARGB(255, 240, 240, 240), fontSize: 16))])),
        ],
      ),
    );
  }

  Widget _helpers3() {
    return SizedBox(
      width: SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * 0.2 : SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * 0.4 : SizeConfig.screenWidth! > 600 ? SizeConfig.screenWidth! - 120 : SizeConfig.screenWidth! > 400 ? SizeConfig.screenWidth! - 60 : SizeConfig.screenWidth! > 300 ? SizeConfig.screenWidth! - 40 : SizeConfig.screenWidth! - 20,
      child: Column(
        crossAxisAlignment: SizeConfig.screenWidth! > 800 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text('Spot-on results', style: GoogleFonts.roboto(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, height: 1.5), textAlign: TextAlign.center),
        Space.spaceHeight(20),
        Text('By harnessing the incredible power of Artificial Intelligence, we’ve designed a system that can tell you everything from when someone went to bed and woke up in the morning and how their chat patterns compare to those of others you know to the probability of them talking to a certain person during the day. Our Whatsapp monitor online status tracker gathers this information and then generates advanced algorithms to predict everything you need to know about what will happen in their Whatsapp feed next.', style: GoogleFonts.roboto(color: const Color.fromARGB(255, 240, 240, 240), fontSize: 16, height: 1.5, letterSpacing: 1), textAlign: SizeConfig.screenWidth! > 800 ? TextAlign.left : TextAlign.center),
      ],
      ),
    );
  }

  Widget _helpers2() {
    return SizedBox(
       width: SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * 0.2 : SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * 0.4 : SizeConfig.screenWidth! > 600 ? SizeConfig.screenWidth! - 120 : SizeConfig.screenWidth! > 400 ? SizeConfig.screenWidth! - 60 : SizeConfig.screenWidth! > 300 ? SizeConfig.screenWidth! - 40 : SizeConfig.screenWidth! - 20,
      child: Column(
      crossAxisAlignment: SizeConfig.screenWidth! > 800 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text('Track online status', style: GoogleFonts.roboto(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, height: 1.5), textAlign: SizeConfig.screenWidth! > 800 ? TextAlign.left : TextAlign.center),
        Space.spaceHeight(20),
        Text('While Whatsapp itself is a great tool, and a seemingly innocuous one as well, its instant and personal nature has led to its being used for some less wholesome activities. With that said, it has been extremely difficult to do anything about that without a Whatsapp last seen tracker online… until now, that is.', style: GoogleFonts.roboto(color: const Color.fromARGB(255, 240, 240, 240), fontSize: 16, height: 1.5, letterSpacing: 1),  textAlign: SizeConfig.screenWidth! > 800 ? TextAlign.left : TextAlign.center),
      ],
      ),
    );
  }

  Widget _helpers1() {
    return SizedBox(
       width: SizeConfig.screenWidth! > 1200 ? SizeConfig.screenWidth! * 0.2 : SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * 0.4 : SizeConfig.screenWidth! > 600 ? SizeConfig.screenWidth! - 120 : SizeConfig.screenWidth! > 400 ? SizeConfig.screenWidth! - 60 : SizeConfig.screenWidth! > 300 ? SizeConfig.screenWidth! - 40 : SizeConfig.screenWidth! - 20,
      child: Column(
        crossAxisAlignment: SizeConfig.screenWidth! > 800 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text('Get peace of mind', style: GoogleFonts.roboto(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, height: 1.5),  textAlign: SizeConfig.screenWidth! > 800 ? TextAlign.left : TextAlign.center),
          Space.spaceHeight(20),
          Text('If you’re in the dark about someone’s chatting habits, tracking their online status on Whatsappcan lift a massive burden off your back. If you suspect a cheating spouse, boyfriend orgirlfriend, for example, there’s nothing worse than living in uncertainty and panicking everytime you see them pull out their phone. Wseen’s Whatsapp last seen tracker online can helpyou to confirm whether or not your suspicions are really true – before you leave your SO on thekerb with their bags in tow, that is. If you have your suspicions about your other half, checkout the Cheaterbuster Tinder monitoring app to gather even more intel.', style: GoogleFonts.roboto(color: const Color.fromARGB(255, 240, 240, 240), fontSize: 16, height: 1.5, letterSpacing: 1),  textAlign: SizeConfig.screenWidth! > 800 ? TextAlign.left : TextAlign.center),
        ],
      ),
    );
  }
}