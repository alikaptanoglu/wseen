import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';
import 'package:weloggerweb/services/services.dart';

class DesktopBar extends StatefulWidget {
  const DesktopBar({Key? key}) : super(key: key);

  @override
  State<DesktopBar> createState() => _DesktopBarState();
}

class _DesktopBarState extends State<DesktopBar> {
  // FirebaseAuth
  final FirebaseAuth auth = FirebaseAuth.instance;

  // User variables
  User? user = FirebaseAuth.instance.currentUser;
  String? userName;

  bool termHover = false;
  bool policyHover = false;
  bool subscriptionHover = false;


  @override
  void initState() {
    getUsername();
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      user = firebaseUser;
      if(user != null) userName = await DbService().getUserInfo(FirebaseAuth.instance.currentUser!.uid);
      if(!mounted) return;
      setState((){});
    });
    super.initState();
  }

  getUsername() async {
    if(user != null) userName = await DbService().getUserInfo(user!.uid);
    if(!mounted) return;
    setState((){});
  }



  @override
  Widget build(BuildContext context) {
    ModelProvider modelProvider = Provider.of<ModelProvider>(context, listen: false);
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Container(
        height: 80,
        width: SizeConfig.isDesktop! ? 1000 : SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: Values.desktopBarHorizontalPadding),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color.fromARGB(255, 60, 60, 60), Color.fromARGB(255, 20, 20, 20), Color.fromARGB(255, 0, 0, 0)], begin: Alignment.topCenter, end: Alignment.bottomCenter), border: Border(bottom: const BorderSide(color: Color.fromARGB(255, 140, 140, 140), width: 0.5),left: BorderSide(color: SizeConfig.screenWidth!> 1000 ? const Color.fromARGB(255, 140, 140, 140) : Colors.transparent, width: 0.5), right: BorderSide(color: SizeConfig.screenWidth! > 1000 ? const Color.fromARGB(255, 140, 140, 140) : Colors.transparent, width: 0.5))),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [appName(context), barSection(modelProvider)],
          ),
        ));
  }

  barSection(ModelProvider modelProvider){
    AuthService authService = AuthService();
    return Row(
            children: [
              userName == null
              ? const SizedBox.shrink()
              : Row(
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ProjectText.rText(text: userName!, fontSize: 20,color: ProjectColors.customColor),
                      ProjectText.rText(text: 'user', fontSize: 14,color: ProjectColors.greyColor),
                    ]),
                    Space.sWidth,
                    Image(image: ImageEnums.denemepersonicon.assetImage, fit: BoxFit.cover, color: ProjectColors.themeColorMOD2, height: 50, width: 50),
                    Space.mWidth,
                    Space.dividerVertical(height: 20, width: 1, color: Colors.white),
                    Space.mWidth,
                    ],
                  ),
                  GestureDetector(
                    onTapDown: (TapDownDetails details) => showPopUpMenu(details.globalPosition),
                    child: Icon(Icons.security, color: ProjectColors.themeColorMOD2, size: 25)),
                  Space.mWidth,
                  GestureDetector(
                    onTap: () {
                      if(userName != null){
                        authService.signOut().whenComplete((){
                        CookieManager.updateUserCookie(isLogin: false);
                        Navigator.of(context).popUntil((route) => route.isFirst);});
                      }else{
                        modelProvider.setSignState(0);
                        
                      }
                    },
                    child: Icon(userName == null ? Icons.login : Icons.logout, color: ProjectColors.themeColorMOD2, size: 30)),
                ],
              );
  }

  Future<void> showPopUpMenu(Offset globalPosition) async {
    SizeConfig.init(context);
    SizeConfig.getDevice();
double left = SizeConfig.isDesktop! ? 1000 : globalPosition.dx;
double right = globalPosition.dx;
double bottom = globalPosition.dy;
double top = globalPosition.dy;

await showMenu(
  color: Colors.white,
  //add your color
  context: context,
  position: RelativeRect.fromLTRB(left, top, right, bottom),
  items: [
    PopupMenuItem(
      value: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 40),
        child: Row(
          children: const [
            Icon(Icons.mail_outline),
            SizedBox(
              width: 10,
            ),
            Text(
              "Term of Use",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    ),
    PopupMenuItem(
      value: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 40),
        child: Row(
          children: const [
            Icon(Icons.vpn_key),
            SizedBox(
              width: 10,
            ),
              Text(
              "Privacy Policy",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    ),
    PopupMenuItem(
      value: 3,
      child: Row(
        children: const [
          Icon(Icons.power_settings_new_sharp),
          SizedBox(
            width: 10,
          ),
            Text(
            "About Subscriptions",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
  ],
  elevation: 8.0,
).then((value) {
  if (value == 1) Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Term()));
  if (value == 2) Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Policy()));
  if (value == 3) Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Subscriptions()));
  });
}

  
  

  // Row _terms() {
  //   return Row(
  //     children: [
  //       MouseRegion(
  //           cursor: SystemMouseCursors.click,
  //           onEnter: (_) => setState(() => termHover = true),
  //           onExit: (_) => setState(() => termHover = false),
  //           child: _term(
  //               'Term of Use',
  //               controller.termHover.value ? ProjectColors.customColor : ProjectColors.greyColor,
  //               () => Navigator.of(context).push(MaterialPageRoute(
  //                     builder: (context) => const Term(),
  //                   )))),
  //       Space.mWidth,
  //       MouseRegion(
  //           cursor: SystemMouseCursors.click,
  //           onEnter: (_) => setState(() => policyHover = true),
  //           onExit: (_) => setState(() => policyHover = false),
  //           child: _term(
  //               'Privacy Policy',
  //               controller.policyHover.value ? ProjectColors.customColor : ProjectColors.greyColor,
  //               () => Navigator.of(context).pushAndRemoveUntil(
  //                   MaterialPageRoute(
  //                     builder: (context) => const Policy(),
  //                   ),
  //                   (route) => false))),
  //       Space.mWidth,
  //       MouseRegion(
  //           cursor: SystemMouseCursors.click,
  //           onEnter: (_) => setState(() => subscriptionHover = true),
  //           onExit: (_) => setState(() => subscriptionHover = false),
  //           child: _term(
  //               'About Subscriptions',
  //               controller.subscriptionsHover.value ? ProjectColors.customColor : ProjectColors.greyColor,
  //               () => Navigator.of(context).pushAndRemoveUntil(
  //                   MaterialPageRoute(
  //                     builder: (context) => const Subscriptions(),
  //                   ),
  //                   (route) => false))),
  //     ],
  //   );
  // }

  // Widget _term(String text, Color color, Function todo) {
  //   return GestureDetector(onTap: () => todo(), child: ProjectText.rText(text: text, fontSize: 16, color: color));
  // }
}
