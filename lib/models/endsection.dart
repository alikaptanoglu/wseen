
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';

class EndSection extends StatefulWidget {
  const EndSection({Key? key}) : super(key: key);

  @override
  State<EndSection> createState() => _EndSectionState();
}

class _EndSectionState extends State<EndSection> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: SizeConfig.screenWidth,
      color: const Color.fromARGB(255, 18, 22, 25),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! > 800 ? (SizeConfig.screenWidth! * 0.2)/4 : SizeConfig.screenWidth! < 400 ? 20 : 40) + const EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            direction: SizeConfig.screenWidth! < 800 ? Axis.vertical : Axis.horizontal,
            children: [
              aboutWseen(),
              SizeConfig.screenWidth! > 800 ?  Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/4) : Space.spaceHeight(60),
              Wrap(
                direction: SizeConfig.screenWidth! < 600 ? Axis.vertical : Axis.horizontal,
                children: [
                  links(),
                  SizeConfig.screenWidth! > 800 ? Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/4) : SizeConfig.screenWidth! < 600 ? Space.spaceHeight(60) : Space.spaceWidth(SizeConfig.screenWidth! - ((SizeConfig.screenWidth! * 0.8) + 80)),
                  contactUs(),
                ],
              ),
            ],
          ),
          Space.spaceHeight(60),
          rights(),
        ],
      ),
    );
  }

  Widget rights(){
    return Align(alignment: Alignment.center, child: Text('©2022. Wseenapps - All Rigths Reserved', style: GoogleFonts.acme(color: Colors.grey, fontSize: 14), textAlign: TextAlign.center));
  }

  Widget contactUs(){
    return SizedBox(
      width: SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * 0.3 : SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! < 400 ? SizeConfig.screenWidth! - 40 : SizeConfig.screenWidth! - 80 : SizeConfig.screenWidth! * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Us', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          SizeConfig.screenWidth! < 600 ? Column(children: [Space.spaceHeight(20), Space.dividerHorizantal(width: SizeConfig.screenWidth! - 80, height: 1, color: Colors.white10), Space.spaceHeight(20)]) : Space.spaceHeight(20),
          Consumer<ModelProvider>(builder: (context, value, child) => RichText(text: TextSpan(text: 'Need help or have a question?\nYou can reach our support team via email for any questions or issues at: ', style: GoogleFonts.roboto(height: 2, color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300), children: [TextSpan(text: 'info@wseen.com', style: GoogleFonts.roboto(height: 2, color: value.supportMailHover ? Colors.white : ProjectColors.themeColorMOD5, fontSize: 16, fontWeight: FontWeight.bold, decoration: value.supportMailHover ? TextDecoration.underline : TextDecoration.none), onEnter: (_) => value.setSupportMailHover(true), onExit: (_) => value.setSupportMailHover(false), recognizer: TapGestureRecognizer()..onTap = () => null)])))
        ],
      ),
    );
  }

  Widget aboutWseen(){
    return SizedBox(
      width: SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * 0.4 : SizeConfig.screenWidth! < 400 ? SizeConfig.screenWidth! - 40 : SizeConfig.screenWidth! - 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Wseen', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          SizeConfig.screenWidth! < 600 ? Column(children: [Space.spaceHeight(20), Space.dividerHorizantal(width: SizeConfig.screenWidth!, height: 1, color: Colors.white10), Space.spaceHeight(20)]) : Space.spaceHeight(20),
          Text('Wseen is a state of the art profile tracker for Whatsapp that enables you to monitor the Whatsapp activity of your friends, family members, coworkers and spouses. Yep – we really did make it happen! Our Whatsapp monitor online status tracker gathers information and then generates advanced algorithms to give you everything you need to know. With such impressive functionality, the only question you have left to ask yourself is… are you ready to know?', style: GoogleFonts.roboto(height: 2, color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }


  Widget links(){
    return SizedBox(
      width: SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * 0.1 : SizeConfig.screenWidth! * 0.2,
      child: Consumer<ModelProvider>(
        builder: (context, value, child) {
          return Wrap(
            direction: Axis.vertical,
            spacing: 10,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/'),
                child: MouseRegion(
                  onEnter: (_) => value.setEndHomeHover(true),
                  onExit: (_) => value.setEndHomeHover(false),
                  cursor: SystemMouseCursors.click,
                  child: Text('Home', style: GoogleFonts.nunito(color: value.endHomeHover ? ProjectColors.themeColorMOD5 :Colors.grey, fontSize: 16, decoration: value.endHomeHover ? TextDecoration.underline : TextDecoration.none))),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/'),
                child: MouseRegion(
                  onEnter: (_) => value.setEndFeaturesHover(true),
                  onExit: (_) => value.setEndFeaturesHover(false),
                  cursor: SystemMouseCursors.click,
                  child: Text('Features', style: GoogleFonts.nunito(color: value.endFeaturesHover ? ProjectColors.themeColorMOD5 :Colors.grey, fontSize: 16, decoration: value.endFeaturesHover ? TextDecoration.underline : TextDecoration.none))),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/online-checker'),
                child: MouseRegion(
                  onEnter: (_) => value.setEndOnlineCheckerHover(true),
                  onExit: (_) => value.setEndOnlineCheckerHover(false),
                  cursor: SystemMouseCursors.click,
                  child: Text('Online Checker', style: GoogleFonts.nunito(color: value.endOnlineCheckerHover ? ProjectColors.themeColorMOD5 :Colors.grey, fontSize: 16, decoration: value.endOnlineCheckerHover ? TextDecoration.underline : TextDecoration.none))),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/last-seen'),
                child: MouseRegion(
                  onEnter: (_) => value.setEndLastSeenHover(true),
                  onExit: (_) => value.setEndLastSeenHover(false),
                  cursor: SystemMouseCursors.click,
                  child: Text('Last Seen', style: GoogleFonts.nunito(color: value.endLastSeenHover ? ProjectColors.themeColorMOD5 :Colors.grey, fontSize: 16, decoration: value.endLastSeenHover ? TextDecoration.underline : TextDecoration.none))),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/privacy-policy'),
                child: MouseRegion(
                  onEnter: (_) => value.setEndPrivacyPolicyHover(true),
                  onExit: (_) => value.setEndPrivacyPolicyHover(false),
                  cursor: SystemMouseCursors.click,
                  child: Text('Privacy Policy', style: GoogleFonts.nunito(color: value.endPrivacyPolicyHover ? ProjectColors.themeColorMOD5 :Colors.grey, fontSize: 16, decoration: value.endPrivacyPolicyHover ? TextDecoration.underline : TextDecoration.none))),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/terms'),
                child: MouseRegion(
                  onEnter: (_) => value.setEndTermsHover(true),
                  onExit: (_) => value.setEndTermsHover(false),
                  cursor: SystemMouseCursors.click,
                  child: Text('Terms', style: GoogleFonts.nunito(color: value.endTermsHover ? ProjectColors.themeColorMOD5 :Colors.grey, fontSize: 16, decoration: value.endTermsHover ? TextDecoration.underline : TextDecoration.none))),
              ),
            ],
          );
        },
      ),
    );
  }
}