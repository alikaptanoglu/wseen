import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/utils.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';
import 'package:weloggerweb/services/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpsignState();
}

class _SignUpsignState extends State<SignUpPage> {

  MouseProvider? mouseProvider;
  ModelProvider? modelProvider;
  final formkey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final List<TextEditingController> controllers = [TextEditingController(),TextEditingController(),TextEditingController()];

  bool rememberMe = false;
  bool passwordVisible = false;

  @override
  void initState() {
    for(var controller in controllers){
      controller.addListener(() { 
        setState(() {
          
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    modelProvider = Provider.of<ModelProvider>(context);
    mouseProvider = Provider.of<MouseProvider>(context);
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Center(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
              _welcomeText(context),
              Space.mHeight,
              SizedBox(
                width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: controllers[0],
                  style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                  decoration: _inputDecoration('Username', Icons.person_outlined, controllers[0]),
                ),
              ),
              Space.sHeight,
              SizedBox(
                width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  validator: (email) => email != null && EmailValidator.validate(email) ? null : 'Enter a valid email',
                  controller: controllers[1],
                  style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                  decoration: _inputDecoration('Email', Icons.email_outlined, controllers[1]),
                ),
              ),
              Space.sHeight,
              SizedBox(
                width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
                child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: !passwordVisible,
                    controller: controllers[2],
                    validator: (password) => password!.length <= 6 ? 'Password ' : null,
                    style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                    decoration: _inputDecoration('Password', Icons.lock_outlined, controllers[2])),
              ),
              Space.sHeight,
              _rememberForgot(context),
              Space.mHeight,
              _signButton(context),
              Space.mHeight,
              _doesntHaveAccount(context),
            ]),
          ),
        ),
    );
  }

  InputDecoration _inputDecoration(String hintText, IconData icon, TextEditingController controller) {
    return InputDecoration(
        suffix: controller == controllers[2] ? GestureDetector(onTap: (() => setState(() => passwordVisible = !passwordVisible)),child: Icon(passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey, size: 20)) : null,
        prefixIcon: Icon(icon, color: controller.text.isEmpty ? Colors.grey : Colors.white, size: 20),
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

  Widget _doesntHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProjectText.rText(text: 'Have an account? ', fontSize: Values.xSValue, color: Colors.grey),
        GestureDetector(
            onTap: () => modelProvider!.toggleSignState(),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => mouseProvider!.toggleDoestHaveAccount(),
                onExit: (_) => mouseProvider!.toggleDoestHaveAccount(),
                child: ProjectText.rText(
                  text: 'Sign In',
                  fontSize: Values.xSValue,
                  color: Colors.blue,
                  decoration: mouseProvider!.doesntHaveAccount ? TextDecoration.underline : TextDecoration.none,
                ))),
      ],
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Column(
      children: [
        ProjectText.rText(text: 'welogger', fontSize: 35, color: ProjectColors.customColor, fontWeight: FontWeight.bold),
        Space.mHeight,
        ProjectText.rText(text: 'sign up and start to track', fontSize: Values.bigValue, color: ProjectColors.greyColor),
      ],
    );
  }

  Widget _signButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        final isValid = formkey.currentState!.validate();
        if (!isValid) return;
        String name = controllers[0].text;
        String email = controllers[1].text;
        String password = controllers[2].text;
        authService.signUp(name, email, password).catchError((error, stackTrace){
          final String errorMessage = error.toString();
          Utils.showSnackBar(text: errorMessage.substring(errorMessage.indexOf(']') + 2, errorMessage.length), );
        }).then((value) {
          if(FirebaseAuth.instance.currentUser != null){
            Utils.showSnackBar(text: 'Successfully registered', color: Colors.green, );
          }
          if(rememberMe){
            value != null ? CookieManager.updateUserCookie(isLogin: true, email: email, password: password) : null;
          }else{
            null;
          }
        });
        clear();
      },
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => mouseProvider!.toggleLoginHover(),
          onExit: (_) => mouseProvider!.toggleLoginHover(),
          child: Container(
            width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
            height: SizeConfig.isMobile! ? 50 : 60,
            decoration: BoxDecoration(
                color: ProjectColors.transparent,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                    color: mouseProvider!.loginHover ? ProjectColors.customColor : ProjectColors.greyColor, width: 1)),
            child: Center(
              child: ProjectText.rText(
                  text: 'Sign Up',
                  fontSize: 20,
                  color: mouseProvider!.loginHover ? ProjectColors.customColor : ProjectColors.greyColor),
            ),
          )),
    );
  }

  Widget _rememberForgot(BuildContext context) {
    return SizedBox(
      height: 20,
      width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Space.emptySpace,
        _rememberPassSignUp(context),
      ]),
    );
  }

  Widget _rememberPassSignUp(BuildContext context) {
    return GestureDetector(
        onTap: () => mouseProvider!.toggleRememberPass(),
        child: Row(
          children: [
            ProjectText.rText(text: 'Remember me', fontSize: Values.xSValue, color: ProjectColors.greyColor),
            Space.xSWidth,
            SizedBox(
              width: 20,
              height: 20,
              child: Theme(
                data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.grey),
                child: Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() => rememberMe = value!);
                  },
                ),
              ),
            ),
          ],
        ));
  }

  clear() {
    controllers[0].clear();
    controllers[1].clear();
    controllers[2].clear();
  }
}
