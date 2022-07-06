import 'package:flutter/material.dart';
import 'package:weloggerweb/models/dialogadd.dart';
import 'package:weloggerweb/models/models.dart';
import '../products/products.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return _body();
  }
  Widget _body() {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Container(
      height: SizeConfig.screenHeight! - Values.barHeight,
      width: SizeConfig.isDesktop! ? 1000 : SizeConfig.screenWidth,
      decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: SizeConfig.screenWidth! > 1000 ? const Color.fromARGB(255, 140, 140, 140) : Colors.transparent, width: 0.5)), color: ProjectColors.opacityDEFb(0.94)),
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAddNumberButton(context),
                _buildContactUser(),
              ],
            ),
          )),
    );
  }

  Widget _buildContactUser() {
    return const ContactCard();
  }

  Widget _buildAddNumberButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return const DialogAdd();
            });
      },
      child: Container(
          width: SizeConfig.isDesktop! ? 1000 : SizeConfig.screenWidth,
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
}
