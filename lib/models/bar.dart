import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';
import 'package:wseen/screens/main.dart';

class MainBar extends StatelessWidget {
  final bool? isMainPage;
  final bool? isTransparent;
  final ScrollController? scrollController;
  const MainBar({Key? key, this.isTransparent = false, this.scrollController, this.isMainPage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    init(context);
    return Column(
      children: [
        _bar(),
        buildMenu(),
      ],
    );
  }

  Widget _bar(){
    Color color = const Color.fromARGB(255, 15, 17, 19);
    return Consumer<ModelProvider>(
      builder:(context, value, child) {
        Color barColor = isTransparent! ? SizeConfig.screenWidth! < 800 ? Colors.black : value.mainScrollPixel > 0 ? color : Colors.transparent : Colors.black;
        return Container(
          width: SizeConfig.screenWidth,
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal! * 6),
          color: barColor,
          child: Row(
            children: [
              Image(image: const AssetImage('assets/images/ic_denemeke.png'), width: SizeConfig.screenWidth! < 600 ? 40 : 45, height: SizeConfig.screenWidth! < 600 ? 40 : 45),
              //ProjectText.rText(text: 'Wseen', fontSize: 20, color: Colors.white),
              Space.expandedSpace(),
              Visibility(
                visible: SizeConfig.screenWidth! > 800 ? true : false,
                child: Wrap(
                      direction: Axis.horizontal,
                      spacing: SizeConfig.blockSizeHorizontal! * 2,
                      children: [
                        GestureDetector(
                          onTap: () {
                            value.setActiveLink(0);
                            if(isMainPage!){
                              scrollController!.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                            }else{
                              Navigator.of(context).pushNamed('/');
                            }
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => value.setHomeHover(true),
                            onExit: (_) => value.setHomeHover(false),
                            child: Text('HOME', style: GoogleFonts.roboto(letterSpacing: 2, color: value.activeLink == 0 ? Colors.white : value.homeHover ? Colors.white : Colors.white.withAlpha(150), fontSize: 12, fontWeight: FontWeight.w300, decoration: value.homeHover ? TextDecoration.underline : TextDecoration.none, decorationThickness: 2, decorationColor: Colors.white))),
                        ),
                        GestureDetector(
                          onTap: () {
                            value.setActiveLink(1);
                            if(isMainPage!){
                              scrollController!.animateTo(SizeConfig.screenWidth! > 1200 ? 1480 : 1600, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                            }else{
                              Navigator.of(context).pushNamed('/');
                            }
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => value.setFeaturesHover(true),
                            onExit: (_) => value.setFeaturesHover(false),
                            child: Text('FEATURES', style: GoogleFonts.roboto(letterSpacing: 2, color: value.activeLink == 1 ? Colors.white : value.featuresHover ? Colors.white : Colors.white.withAlpha(150), fontSize: 12, fontWeight: FontWeight.w300, decoration: value.featuresHover ? TextDecoration.underline : TextDecoration.none, decorationThickness: 2, decorationColor: Colors.white))),
                        ),
                        GestureDetector(
                          onTap: () {
                            value.setActiveLink(2);
                            Navigator.of(context).pushNamed('/online-checker');
                          }, 
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => value.setOnlineCheckerHover(true),
                            onExit: (_) => value.setOnlineCheckerHover(false),
                            child: Text('ONLINE CHECKER', style: GoogleFonts.roboto(letterSpacing: 2, color: value.activeLink == 2 ? Colors.white : value.onlineCheckerHover ? Colors.white : Colors.white.withAlpha(150), fontSize: 12, fontWeight: FontWeight.w300, decoration: value.onlineCheckerHover ? TextDecoration.underline : TextDecoration.none, decorationThickness: 2, decorationColor: Colors.white))),
                        ),
                        GestureDetector(
                          onTap: () {
                            value.setMenu(false);
                            value.setActiveLink(3);
                            Navigator.of(context).pushNamed('/last-seen');
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => value.setLastSeenHover(true),
                            onExit: (_) => value.setLastSeenHover(false),
                            child: Text('LAST SEEN', style: GoogleFonts.roboto(letterSpacing: 2, color: value.activeLink == 3 ? Colors.white : value.lastSeenHover ? Colors.white : Colors.white.withAlpha(150), fontSize: 12, fontWeight: FontWeight.w300, decoration: value.lastSeenHover ? TextDecoration.underline : TextDecoration.none, decorationThickness: 2, decorationColor: Colors.white))),
                        ),
                      ],
                    ),
                ),
              Space.expandedSpace(),
              SizeConfig.screenWidth! > 800 
              ? Consumer<ModelProvider>(
                builder: (context, value, child) {
                  return GestureDetector(
                    onTap: (){
                      value.setMenu(false);
                      Navigator.of(context).pushNamed('/sign');
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => value.setSignHover(true),
                      onExit: (_) => value.setSignHover(false),
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(color: value.signHover ? ProjectColors.themeColorMOD5 : ProjectColors.themeColorMOD5.withAlpha(220), borderRadius: BorderRadius.circular(5)),
                        child: Center(child: Text('SIGN IN', style: GoogleFonts.roboto(fontSize: 14, color: Colors.white))),
                      ),  
                    ),
                  );
                },
              ) : GestureDetector(
                onTap: () {
                  if(value.menuAnimStatus){
                    value.isMenuOpen ? value.setMenu(false) : value.setMenu(true);
                    value.setMenuAnimStatus(false);
                  }
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(Icons.menu, color: Colors.white, size: 30))),
            ],
          ),
        );
      },
    );
  }

  Widget buildMenu(){
    return Consumer<ModelProvider>(
      builder: (context, value, child) {
        return AnimatedContainer(
          onEnd: () => value.setMenuAnimStatus(true),
          curve: Curves.bounceOut,
          duration: const Duration(seconds: 1),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: SizeConfig.screenWidth!,
          height: value.isMenuOpen ? 380 : 0,
          color: const Color.fromARGB(255, 12, 15, 17),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    value.setMenu(false);
                    value.setActiveLink(0);
                    if(isMainPage!){
                      scrollController!.position.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Main()));
                    }
                  },
                  child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => value.setHomeHover(true),
                    onExit: (_) => value.setHomeHover(false),
                    child: Container(
                      width: SizeConfig.screenWidth! - 80,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: ProjectText.rText(text: 'HOME', fontSize: 12, color: value.homeHover ? Colors.white : Colors.white60, letterSpacing: 1))),
                ),
                Space.dividerHorizantal(width: SizeConfig.screenWidth! - 80, color: Colors.white10, height: 1),
                GestureDetector(
                  onTap: () {
                    value.setMenu(false);
                    value.setActiveLink(1);
                    if(isMainPage!){
                      scrollController!.position.animateTo(SizeConfig.screenWidth! > 600 ? 1850 : 1600, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Main()));
                    }
                  },
                  child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => value.setFeaturesHover(true),
                    onExit: (_) => value.setFeaturesHover(false),
                    child: Container(
                      width: SizeConfig.screenWidth! - 80,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: ProjectText.rText(text: 'FEATURES', fontSize: 12, color: value.featuresHover ? Colors.white : Colors.white60, letterSpacing: 1))),
                ),
                Space.dividerHorizantal(width: SizeConfig.screenWidth! - 80, color: Colors.white10, height: 1),
                GestureDetector(
                  onTap: (){
                    value.setMenu(false);
                    value.setActiveLink(2);
                    Navigator.of(context).pushNamed('/online-checker');
                  },
                  child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => value.setOnlineCheckerHover(true),
                    onExit: (_) => value.setOnlineCheckerHover(false),
                    child: Container(
                      width: SizeConfig.screenWidth! - 80,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: ProjectText.rText(text: 'ONLINE CHECKER', fontSize: 12, color: value.onlineCheckerHover ? Colors.white : Colors.white60, letterSpacing: 1))),
                ),
                Space.dividerHorizantal(width: SizeConfig.screenWidth! - 80, color: Colors.white10, height: 1),
                GestureDetector(
                  onTap: () {
                    value.setMenu(false);
                    value.setActiveLink(3);
                    Navigator.of(context).pushNamed('/last-seen');
                  },
                  child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => value.setLastSeenHover(true),
                    onExit: (_) => value.setLastSeenHover(false),
                    child: Container(
                      width: SizeConfig.screenWidth! - 80,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: ProjectText.rText(text: 'LAST SEEN', fontSize: 12, color: value.lastSeenHover ? Colors.white : Colors.white60, letterSpacing: 1))),
                ),
                Space.spaceHeight(20),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/sign'),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: SizeConfig.screenWidth! - 80,
                      height: 50,
                      decoration: BoxDecoration(color: ProjectColors.themeColorMOD5, borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text('SIGN IN', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, letterSpacing: 2))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void init(BuildContext context) {
    SizeConfig.init(context);
  }
}


class CustomBar extends StatelessWidget {
  const CustomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: SizeConfig.screenWidth,
      height: 60,
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white30, width: 1)), color: Color.fromARGB(255, 10, 10, 12)),
      child: Center(child: Image(image: const AssetImage('assets/images/ic_denemeke.png'), width: SizeConfig.screenWidth! < 600 ? 35 : 40, height: SizeConfig.screenWidth! < 600 ? 35 : 40)));
  }
}