import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/utils.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';
import 'package:wseen/screens/screens.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

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
    mouseProvider = Provider.of<MouseProvider>(context, listen: false);
    SizeConfig.init(context);
    return Scaffold(
      body: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: 80,
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white30, width: 1)), color: Color.fromARGB(255, 10, 10, 12)),
              child: const Center(child: Text('Wseen', style: TextStyle(color: Colors.white, fontSize: 30))),
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! - 80,
              padding: ProjectPadding.horizontalPadding(value: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [text(), Space.mHeight, field(), Space.mHeight, button()]),
            ),
          ],
        ),
      ),
    );
  }

  Widget text() => const Text('Receive an email to reset your password',
      maxLines: 2,
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontSize: 26));

  Widget field() {
    return SizedBox(
      width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
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
          width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
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
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).whenComplete(() => Utils.showSnackBar(text: 'Password reset email sent', color: Colors.green, )).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Sign())));
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pushNamed('/sign');
      Utils.showSnackBar(text: e.message);
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
