import 'package:flutter/material.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';

class Forgot extends StatelessWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(image: DecorationImage(image: ImageEnums.webbackgroundimage.assetImage, repeat: ImageRepeat.repeat)),
        child: Center(
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.isDesktop! ? 1000 : SizeConfig.screenWidth,
            decoration: BoxDecoration(color: ProjectColors.opacityDEFb(0.94), border: Border.symmetric(vertical: BorderSide(color: SizeConfig.screenWidth! > 1000 ? const Color.fromARGB(255, 140, 140, 140) : Colors.transparent, width: 0.5))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const WebBar(),
                  SizeConfig.isDesktop! 
                  ? const SingleChildScrollView(child: ForgotPage()) 
                  : SingleChildScrollView(child: Stack(
                      children: const [ForgotPage(), MobileMenu()]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
