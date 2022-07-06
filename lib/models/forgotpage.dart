import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/utils.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {

  MouseProvider? mouseProvider;

  final TextEditingController emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final bool sendReset = false;

  @override
  void initState() {
    emailController.addListener(() { 
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mouseProvider = Provider.of<MouseProvider>(context);
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Container(
      height: SizeConfig.screenHeight! - Values.barHeight,
      width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
      padding: ProjectPadding.horizontalPadding(value: 40),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [text(), Space.mHeight, field(), Space.mHeight, button()]),
    );
  }

  Widget text() => const Text('Receive an email to reset your password',
      maxLines: 2,
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontSize: 26));

  Widget field() {
    return SizedBox(
      width: Values.mobileInputFieldWidth,
      child: Form(
        key: formkey,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(color: ProjectColors.customColor),
          validator: (email) => email != null && EmailValidator.validate(email) ? null : 'Enter a valid email',
          controller: emailController,
          decoration: _inputDecoration('Email', emailController),
        ),
      ),
    );
  }

  Widget button() {
    return GestureDetector(
      onTap: () => sendPasswordResetEmail(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => mouseProvider!.toggleResetHover(),
        onExit: (_) => mouseProvider!.toggleResetHover(),
        child: Container(
          width: Values.mobileInputFieldWidth,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: mouseProvider!.resetHover ? ProjectColors.customColor : ProjectColors.greyColor, width: 1)),
          child: Center(
              child: Text(
                'Reset password',
                style: TextStyle(
                    color: mouseProvider!.resetHover ? ProjectColors.customColor : ProjectColors.greyColor,
                    fontSize: 16),
              )),
        ),
      ),
    );
  }

  sendPasswordResetEmail() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).whenComplete(() => Utils.showSnackBar(text: 'Password reset email sent', color: Colors.green, )).then((value) => Navigator.popUntil(context, (route) => route.isFirst));
    } on FirebaseAuthException catch (e) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Utils.showSnackBar(text: e.message, );
    }
  }
}

InputDecoration _inputDecoration(String hintText, TextEditingController controller) {
  return InputDecoration(
      prefixIcon: Icon(Icons.email,color: controller.text.isEmpty ? Colors.grey : Colors.white,size: 20),
      contentPadding: ProjectPadding.horizontalPadding(value: 10),
      hintText: hintText,
      hintStyle: TextStyle(color: ProjectColors.greyColor, fontSize: 14),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ProjectColors.greyColor, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ProjectColors.customColor, width: 1),
      ));
}
