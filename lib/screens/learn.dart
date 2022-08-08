import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/modelprovider.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({Key? key}) : super(key: key);

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {

  ScrollController scrollController = ScrollController();
  double scrollPosition = 0;

  @override
  void initState() {
    scrollController.addListener(() => setState(() => scrollPosition = scrollController.position.pixels));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      floatingActionButton: Visibility(visible: scrollPosition > SizeConfig.screenWidth!/2, child: FloatingActionButton(backgroundColor: ProjectColors.themeColorMOD5, child: const Icon(Icons.arrow_upward), onPressed: () => scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn))),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.back.assetImage, fit: BoxFit.cover)),
        child: Center(
          child: Container(
            color: ProjectColors.customColor,
            width: SizeConfig.screenWidth! >= 400 ? 400 : SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Column(
              children: [
                bar(context),
                guide()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget guide() {
    return Container(
      padding: const EdgeInsets.all(30),
      width: SizeConfig.screenWidth! >= 400 ? 400 : SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! - 80,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            ProjectText.rText(text: 'You can log in instantly by installing the application on your phone. We have shown below what you need to do to install the application on your phone.', fontSize: 14, color: ProjectColors.onlineColor, textAlign: TextAlign.left),
            Space.spaceHeight(30),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Provider.of<ModelProvider>(context, listen: false).setAndroidOrIOS(0),
                    child: Consumer<ModelProvider>(builder: (context, value, child) {
                      return Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color.fromARGB(255, 250, 250, 250), borderRadius: BorderRadius.circular(5), border: Border.all(color: value.androidOrIOS == 0 ? Colors.blue : Colors.transparent, width: 1)),child: const Icon(FontAwesomeIcons.appStoreIos, size: 40, color: Colors.lightBlue));
                    })),
                  Space.spaceWidth(SizeConfig.screenWidth! > 400 ? 280/3 : (SizeConfig.screenWidth! - 120)/3),
                  GestureDetector(
                    onTap: () => Provider.of<ModelProvider>(context, listen: false).setAndroidOrIOS(1),
                    child: Consumer<ModelProvider>(builder:(context, value, child) {
                      return Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color.fromARGB(255, 250, 250, 250), borderRadius: BorderRadius.circular(5), border: Border.all(color: value.androidOrIOS == 1 ? Colors.green : Colors.transparent, width: 1)),child: const Icon(FontAwesomeIcons.android, size: 40, color: Colors.green));
                    })),
                ],
              ),
            ),
            Space.spaceHeight(30),
            Consumer<ModelProvider>(
              builder: (context, value, child) {
                return IndexedStack(
                  index: value.androidOrIOS,
                  children: [
                    apple(),
                    android(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget apple(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(FontAwesomeIcons.appStoreIos, size: 35, color: Colors.lightBlue),
            Space.spaceWidth(20),
            Text('For IOS', style: GoogleFonts.poppins(color: Colors.black, fontSize: 25))
          ],
        ),
        Space.spaceHeight(10),
        buildStep('1','First Step', 'Click where indicated by the arrow.', ImageEnums.learnandroidone.assetImage),
        Space.spaceHeight(20),
        buildStep('2','Second Step', 'Click where indicated by the arrow.', ImageEnums.learnandroidtwo.assetImage),
      ],
    );
  }

  Widget android() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(FontAwesomeIcons.android, size: 35, color: Colors.green),
            Space.spaceWidth(20),
            Text('For Android', style: GoogleFonts.poppins(color: Colors.black, fontSize: 25))
          ],
        ),
        Space.spaceHeight(10),
        buildStep('1','First Step', 'Click where indicated by the arrow.', ImageEnums.learnandroidone.assetImage),
        Space.spaceHeight(20),
        buildStep('2','Second Step', 'Click where indicated by the arrow.', ImageEnums.learnandroidtwo.assetImage),
        Space.spaceHeight(20),
        buildStep('3','Third Step', 'Click where indicated by the arrow.', ImageEnums.learnandroidthree.assetImage),
        Space.spaceHeight(20),
        buildStep('4','Fourth Step', 'Click where indicated by the arrow.', ImageEnums.learnandroidfour.assetImage),
      ],
    );
  }

  Widget buildStep(String stepNumber,String stepText, String helpText, ImageProvider image) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(width: 35, height: 35, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1)), child: Center(child: Text(stepNumber, style: GoogleFonts.roboto(color: Colors.black, fontSize: 20)))),
              Space.spaceWidth(20),
              Text(stepText, style: GoogleFonts.poppins(color: Colors.black, fontSize: 18))
            ],
          ),
        ),
        Space.spaceHeight(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft, child: ProjectText.rText(text: helpText, fontSize: 16, color: Colors.black)),
              Space.spaceHeight(10),
              Container(
                width: SizeConfig.screenWidth! - 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                child: SizedBox(width: SizeConfig.screenWidth! - 100, child: Image(image: image, fit: BoxFit.cover))),
            ],
          ),
        ),
      ],
    );
  }

  Widget bar(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: ProjectColors.themeColorMOD3, border: const Border(bottom: BorderSide(color: Color.fromARGB(255, 40, 40, 40)))),
      child: Row(
        children: [
          GestureDetector(
              //onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: ((context) => const HomePage())), (route) => false),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: ProjectColors.themeColorMOD4, borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.keyboard_arrow_left, color: ProjectColors.themeColorMOD5, size: 25)),
            ),
            Space.spaceWidth(SizeConfig.screenWidth! < 350 ? 25 : 40),
            ProjectText.rText(text: 'Download APP', fontSize: SizeConfig.screenWidth! < 350 ? 19 : 20, color: ProjectColors.customColor)
        ],
      ),
    );
  }
}