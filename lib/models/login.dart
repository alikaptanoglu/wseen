import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/models/utils.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';
import 'package:wseen/services/auth.dart';
import 'package:wseen/services/cookie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginsignState();
}

class _LoginsignState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final List<TextEditingController> _controllers = [TextEditingController(),TextEditingController()];

  bool passwordVisible = false;
  bool showEmailValidate = false;

  @override
  void initState() {
    for(var controller in _controllers){
      controller.addListener(() { 
        setState(() {
          
        });
      });
    }
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return _login(context);
  }

  Widget _login(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 17, 19),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            const CustomBar(),
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! - 60,
              child: Center(
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        _welcomeText(context),
                        Space.spaceHeight(50),
                        _buildForm(context),
                        Space.spaceHeight(20),
                        SizedBox(
                          width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
                          child: Visibility(
                            visible: showEmailValidate,
                            child: Column(
                              children: [
                                ProjectText.rText(text: '*Email must be valid email and password must have more than six characters.', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red, textAlign: TextAlign.center),
                                Space.spaceHeight(20),
                              ],
                            ),
                          ),
                        ),
                        _signInButton(context),
                        Space.spaceHeight(20),
                        _doesntHaveAccount(context),
                        Space.spaceHeight(10),
                        _forgotPass(context),
                      ]),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
            child: Theme(
              data: Theme.of(context).copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary:Colors.white)),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: _controllers[0],
                style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                decoration: _inputDecoration('Email', 'Email', Icons.email_outlined, _controllers[0]),
              ),
            ),
          ),
          Space.sHeight,
          SizedBox(
            width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
            child: Theme(
              data: Theme.of(context).copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary:Colors.white)),
              child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: !passwordVisible,
                  controller: _controllers[1],
                  style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                  decoration: _inputDecoration('Password', 'Password', Icons.lock_outline, _controllers[1])),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String text, String labelText, IconData icon, TextEditingController textEditingController) {
    return InputDecoration( 
        suffix: textEditingController == _controllers[1] ? GestureDetector(onTap:() => setState(() => passwordVisible = !passwordVisible), child: Icon(passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey, size: 20)) : Space.emptySpace,
        prefixIcon: Icon(icon, color: textEditingController.text.isEmpty ? Colors.grey : Colors.white, size: 20),
        contentPadding: ProjectPadding.horizontalPadding(value: 20),
        hintText: text,
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

  Widget _forgotPass(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('/forgot'),
          child: ProjectText.rText(
              text: 'Forgot Password',
              fontSize: 12,
              color: Colors.blue,
              decoration: TextDecoration.none)),
    );
  }

  Widget _doesntHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProjectText.rText(text: 'Does not have an account? ', fontSize: Values.xSValue, color: Colors.grey),
        GestureDetector(
            onTap: () => Provider.of<ModelProvider>(context, listen: false).toggleSignState(),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => Provider.of<MouseProvider>(context, listen: false).toggleDoestHaveAccount(),
                onExit: (_) => Provider.of<MouseProvider>(context, listen: false).toggleDoestHaveAccount(),
                child: ProjectText.rText(
                  text: 'Sign Up',
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
        ProjectText.rText(text: 'login and start to track', maxLines: 1, fontSize: SizeConfig.screenWidth! < 350 ? 17 : 20, color: ProjectColors.greyColor),
      ],
    );
  }

  Widget _signInButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        String email = _controllers[0].text;
        String password = _controllers[1].text;
        if(!EmailValidator.validate(email)) {
          setState(() {
            showEmailValidate = true;
          });
          return; 
        } else {
          setState(() {
            showEmailValidate = false;
          });
        }
        showDialog(context: context,builder: (BuildContext context) => loadingWidget());
        authService.signIn(email, password).whenComplete(() => Navigator.of(context).pop()).catchError((error, stackTrace) {
          final String errorMessage = error.toString();
          Utils.showSnackBar(text: errorMessage.substring(errorMessage.indexOf(']') + 2, errorMessage.length));
        }).then((value){
          if(value != null){
            CookieManager.updateUserCookie(isLogin: true, email: email, password: password);
            Navigator.of(context).pushNamedAndRemoveUntil('/monitor', (route) => false);
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
          height: SizeConfig.screenWidth! < 600 ? 45 : 50,
          decoration: BoxDecoration(
              color: ProjectColors.transparent,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: context.watch<MouseProvider>().loginHover ? ProjectColors.customColor : ProjectColors.greyColor, width: 1)),
          child: Center(
            child: ProjectText.rText(
                text: 'Sign In',
                fontSize: 20,
                color: context.watch<MouseProvider>().loginHover ? ProjectColors.customColor : ProjectColors.greyColor),
          ),
        ),
      ),
    );
  }

  clear() {
    _controllers[0].clear();
    _controllers[1].clear();
  }
}
