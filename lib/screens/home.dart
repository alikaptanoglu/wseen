
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';
import 'package:weloggerweb/services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    SizeConfig.init(context);
    SizeConfig.getDevice();

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if(snapshot.connectionState == ConnectionState.waiting) return Center(child: Image(image: ImageEnums.homelogo.assetImage, width: 60, height: 60, color: Colors.white));
          if (snapshot.hasData) {
            //final bool isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
            return monitor();
            //isVerified ? const Monitor() : const Verification();
          }else{
            return const Sign();
          }
        }); 
  }

  Widget monitor(){
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Scaffold(
      backgroundColor: ProjectColors.opacityDEFb(0.94),
      body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.webbackgroundimage.assetImage, repeat: ImageRepeat.repeat)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const WebBar(),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight! - Values.barHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizeConfig.isDesktop!
                            ? const HomeBody()
                            : Stack(
                                children: const [HomeBody(), MobileMenu()],
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}


class Sign extends StatefulWidget {
  const Sign({Key? key,}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  

  ModelProvider? modelProvider;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    print(i);
    modelProvider = Provider.of<ModelProvider>(context);
    if(i == 0) loginOrSign();
    i++;
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Scaffold(
    body: Container(
            width: SizeConfig.screenWidth!,
            height: SizeConfig.screenHeight!,
            decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.webbackgroundimage.assetImage, repeat: ImageRepeat.repeat)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const WebBar(),
                  Container(
                    width: SizeConfig.isDesktop! ? 1000 : SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight! - Values.barHeight,
                    decoration: BoxDecoration(color: ProjectColors.opacityDEFb(0.94),border: Border.symmetric(vertical: BorderSide(color: SizeConfig.screenWidth! > 1000 ? const Color.fromARGB(255, 140, 140, 140) : Colors.transparent, width: 0.5))),
                    child: SizeConfig.isDesktop! ? 
                          IndexedStack(
                            alignment: Alignment.center,
                            index: modelProvider!.signState,
                            children: const [
                              LoginPage(),
                              SignUpPage(),
                            ],
                          )
                        : Stack(
                          alignment: Alignment.center,
                          children: [
                            IndexedStack(
                              alignment: Alignment.center,
                              index: modelProvider!.signState,
                              children: const [
                                LoginPage(),
                                SignUpPage(),
                              ],
                            ),
                            const MobileMenu()
                          ],
                        ),
                  ),
                ],
              ),
            ),
      ),
  );
  }

  loginOrSign(){
    final bool isLogged = CookieManager.getCookieAsMap()!.containsKey('email');
    if(isLogged) modelProvider!.toggleSignState();
  }
}



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weloggerweb/models/models.dart';
// import 'package:weloggerweb/products/products.dart';
// import 'package:weloggerweb/providers/providers.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   ModelProvider? modelProvider;

//   @override
//   Widget build(BuildContext context) {

//     modelProvider = Provider.of<ModelProvider>(context, listen: false);
//     SizeConfig.init(context);
//     SizeConfig.getDevice();

//     return StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           //if(snapshot.connectionState == ConnectionState.waiting) return Center(child: Image(image: ImageEnums.homelogo.assetImage, width: 60, height: 60, color: Colors.white));
//           if (snapshot.hasData) {
//             //final bool isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//             return monitor();
//             //isVerified ? const Monitor() : const Verification();
//           }else{
//             return sign();
//           }
//         }); 
//   }

  // Widget sign(){
  // return Scaffold(
  //   resizeToAvoidBottomInset: false,
  //   body: SizedBox(
  //           width: SizeConfig.screenWidth!,
  //           height: SizeConfig.screenHeight!,
  //           child: Column(
  //             children: [
  //               const WebBar(),
  //               SizedBox(
  //                 width: SizeConfig.screenWidth,
  //                 height: SizeConfig.screenHeight! - Values.barHeight,
  //                 child: SizeConfig.isDesktop! ? 
  //                       Row(children: [
  //                         const DesktopMenu(),
  //                         IndexedStack(
  //                           alignment: Alignment.center,
  //                           index: modelProvider!.signState,
  //                           children: const [
  //                             LoginPage(),
  //                             SignUpPage(),
  //                           ],
  //                         ),
  //                       ])
  //                     : Stack(
  //                         alignment: Alignment.center,
  //                         children: [
  //                           IndexedStack(
  //                             alignment: Alignment.center,
  //                             index: modelProvider!.signState,
  //                             children: const [
  //                               LoginPage(),
  //                               SignUpPage(),
  //                             ],
  //                           ),
  //                           const MobileMenu()
  //                         ],
  //                       ),
  //               ),
  //             ],
  //           ),
  //     ),
  // );
  // }


//   Widget monitor(){
//     return Scaffold(
//       body: SizedBox(
//           height: SizeConfig.screenHeight,
//           width: SizeConfig.screenWidth,
//           child: Column(
//             children: [
//               const WebBar(),
//               SizedBox(
//                 width: SizeConfig.screenWidth,
//                 height: SizeConfig.screenHeight! - Values.barHeight,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizeConfig.isDesktop!
//                           ? Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 DesktopMenu(),
//                                 HomeBody(),
//                               ],
//                             )
//                           : Stack(
//                               children: const [HomeBody(), MobileMenu()],
//                             )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//     );
//   }

// }


