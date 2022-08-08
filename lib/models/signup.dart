import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/models/utils.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';
import 'package:wseen/services/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpsignState();
}

class _SignUpsignState extends State<SignUpPage> {

  bool validatorError = false;
  BuildContext? loadingContext;
  final AuthService authService = AuthService();

  final List<TextEditingController> controllers = [TextEditingController(),TextEditingController(),TextEditingController()];
  bool passwordVisible = false;
  dynamic notificationToken;

  @override
  void initState() {
    _getToken();
    for(var controller in controllers){
      controller.addListener(() { 
        setState(() {
          
        });
      });
    }
    super.initState();
  }

  _getToken() async {
    notificationToken = await getToken();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 17, 19),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 22, 22, 25), Colors.black, Color.fromARGB(255, 15, 17, 19)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            const CustomBar(),
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! - 60,
              child: Center(
                  child: Form(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            _welcomeText(context),
                            Space.spaceHeight(50),
                            _buildForm(),
                            _buildError(),
                            Space.lHeight,
                            _signButton(context),
                            Space.mHeight,
                            _doesntHaveAccount(context),
                          ]
                        ),
                      ),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        SizedBox(
          width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: controllers[0],
            style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
            decoration: _inputDecoration('Username', 'Username', Icons.person_outlined, controllers[0]),
          ),
        ),
        Space.sHeight,
        SizedBox(
          width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: controllers[1],
            style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
            decoration: _inputDecoration('Email', 'Email', Icons.email_outlined, controllers[1]),
          ),
        ),
        Space.sHeight,
        SizedBox(
          width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
          child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              obscureText: !passwordVisible,
              controller: controllers[2],
              style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
              decoration: _inputDecoration('Password', 'Password', Icons.lock_outlined, controllers[2])),
        ),
      ],
    );
  }

 

  Widget _buildError() {
    return Visibility(
      visible: validatorError,
      child: SizedBox(
        width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
        child: Column(
          children: [
            Space.mHeight,
            ProjectText.rText(text: '*Email must be a valid and password must have more than six characters', fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText, String labelText, IconData icon, TextEditingController controller) {
    return InputDecoration(
        suffix: controller == controllers[2] ? GestureDetector(onTap: (() => setState(() => passwordVisible = !passwordVisible)),child: Icon(passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey, size: 20)) : null,
        prefixIcon: Icon(icon, color: controller.text.isEmpty ? Colors.grey : Colors.white, size: 20),
        contentPadding: ProjectPadding.horizontalPadding(value: 10),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: ProjectColors.greyColor, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ProjectColors.greyColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ProjectColors.customColor, width: 1),
        ));
  }

  Widget _doesntHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProjectText.rText(text: 'Have an account? ', fontSize: Values.xSValue, color: Colors.grey),
        GestureDetector(
            onTap: () => Provider.of<ModelProvider>(context, listen: false).toggleSignState(),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => Provider.of<MouseProvider>(context, listen: false).toggleDoestHaveAccount(),
                onExit: (_) => Provider.of<MouseProvider>(context, listen: false).toggleDoestHaveAccount(),
                child: ProjectText.rText(
                  text: 'Sign In',
                  fontSize: Values.xSValue,
                  color: Colors.blue,
                  decoration: Provider.of<MouseProvider>(context, listen: false).doesntHaveAccount ? TextDecoration.underline : TextDecoration.none,
                ))),
      ],
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Column(
      children: [
        ProjectText.rText(text: 'wseen', maxLines: 1, fontSize: SizeConfig.screenWidth! < 350 ? 30 : 35, color: ProjectColors.customColor, fontWeight: FontWeight.bold),
        Space.spaceHeight(10),
        ProjectText.rText(text: 'sign up and start to track', maxLines: 1, fontSize: SizeConfig.screenWidth! < 350 ? 17 : 20, color: ProjectColors.greyColor),
      ],
    );
  }

  Widget _signButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        String name = controllers[0].text;
        String email = controllers[1].text;
        String password = controllers[2].text;
        bool emailVal = EmailValidator.validate(email);
        bool passwordVal = password.length < 6 ? false : true;
        if(!emailVal || !passwordVal) {
          setState(() {
            validatorError = true;
          });
          return;
        }
        String subscriptionType = Provider.of<ModelProvider>(context, listen: false).subscriptionType == 0 ? 'free' : 'premium';
        showDialog(context: context, builder: (BuildContext context) {
          loadingContext = context;
          return loadingWidget();
        });
        authService.signUp(name, email, password, notificationToken, subscriptionType).catchError((error, stackTrace){
          final String errorMessage = error.toString();
          Utils.showSnackBar(text: errorMessage.substring(errorMessage.indexOf(']') + 2, errorMessage.length) );
        }).then((value) {
          Navigator.of(loadingContext!).pop();
          if(value != null){
            Utils.showSnackBar(text: 'Successfully registered', color: Colors.green);
            CookieManager.updateUserCookie(isLogin: true, email: email, password: password);
            Future.delayed(const Duration(seconds: 2), () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Monitor()), (route) => true);
            });
          }
        });
        clear();
      },
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => Provider.of<MouseProvider>(context, listen: false).toggleLoginHover(),
          onExit: (_) => Provider.of<MouseProvider>(context, listen: false).toggleLoginHover(),
          child: Container(
            width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
            height: SizeConfig.screenWidth! < 400 ? 45 : 50,
            decoration: BoxDecoration(
                color: ProjectColors.transparent,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                    color:  context.watch<MouseProvider>().loginHover ? ProjectColors.customColor : ProjectColors.greyColor, width: 1)),
            child: Center(
              child: ProjectText.rText(
                  text: 'Sign Up',
                  fontSize: 20,
                  color: context.watch<MouseProvider>().loginHover ? ProjectColors.customColor : ProjectColors.greyColor),
            ),
          )),
    );
  }

  clear() {
    controllers[0].clear();
    controllers[1].clear();
    controllers[2].clear();
  }

  Future<dynamic> getToken() async {
    try{
      final notificationToken = await FirebaseMessaging.instance.getToken();
      return Future.value(notificationToken);
    } on Exception catch (e){
      return Future.value(null);
    }
  }
}
