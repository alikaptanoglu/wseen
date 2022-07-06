import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/globalvalues/globalvalues.dart';
import 'package:weloggerweb/models/loading.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/models/utils.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';
import 'package:weloggerweb/screens/screens.dart';
import 'package:weloggerweb/services/auth.dart';
import 'package:weloggerweb/services/cookie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginsignState();
}

class _LoginsignState extends State<LoginPage> {

  ModelProvider? modelProvider;
  MouseProvider? mouseProvider;
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final List<TextEditingController> _controllers = [TextEditingController(),TextEditingController()];
  final List<FocusNode> _focusNodes = [FocusNode(), FocusNode()];

  bool rememberMe = false;
  bool passwordVisible = false;

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
    modelProvider = Provider.of<ModelProvider>(context);
    mouseProvider = Provider.of<MouseProvider>(context);
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Center(
      child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            _welcomeText(context),
            Space.mHeight,
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
                    child: Theme(
                      data: Theme.of(context).copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary:Colors.white)),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        focusNode: _focusNodes[0],
                        validator: (email) => email != null && EmailValidator.validate(email) ? null : 'Enter a valid email',
                        controller: _controllers[0],
                        style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                        decoration: _inputDecoration('Email', Icons.email_outlined, _controllers[0]),
                      ),
                    ),
                  ),
                  Space.sHeight,
                  SizedBox(
                    width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
                    child: Theme(
                      data: Theme.of(context).copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary:Colors.white)),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: !passwordVisible,
                          focusNode: _focusNodes[1],
                          controller: _controllers[1],
                          style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                          decoration: _inputDecoration('Password', Icons.lock_outline, _controllers[1])),
                    ),
                  ),
                ],
              ),
            ),
            Space.sHeight,
            _rememberForgot(context),
            Space.mHeight,
            _signInButton(context),
            Space.mHeight,
            _doesntHaveAccount(context),
          ]),
        ),
    );
  }

  InputDecoration _inputDecoration(String text, IconData icon, TextEditingController textEditingController) {
    return InputDecoration(
        suffix: textEditingController == _controllers[1] ? GestureDetector(onTap:() => setState(() => passwordVisible = !passwordVisible), child: Icon(passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey, size: 20)) : null,
        prefixIcon: Icon(icon, color: textEditingController.text.isEmpty ? Colors.grey : Colors.white, size: 20),
        contentPadding: ProjectPadding.horizontalPadding(value: 10),
        hintText: text,
        hintStyle: TextStyle(color: ProjectColors.greyColor, fontSize: 14),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.greyColor, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.customColor, width: 1),
        ));
  }

  Widget _forgotPass(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Forgot())),
        child: ProjectText.rText(
            text: 'Forgot Password',
            fontSize: Values.xSValue,
            color: Colors.blue,
            decoration: controller.forgotHover.value ? TextDecoration.underline : TextDecoration.none));
  }

  Widget _doesntHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProjectText.rText(text: 'Does not have an account? ', fontSize: Values.xSValue, color: Colors.grey),
        GestureDetector(
            onTap: () => modelProvider!.toggleSignState(),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => mouseProvider!.toggleDoestHaveAccount(),
                onExit: (_) => mouseProvider!.toggleDoestHaveAccount(),
                child: ProjectText.rText(
                  text: 'Sign Up',
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
        ProjectText.rText(text: 'login and start to track', fontSize: Values.bigValue, color: ProjectColors.greyColor),
      ],
    );
  }

  Widget _signInButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        final isValid = formKey.currentState!.validate();
        if (!isValid) return;
        String email = _controllers[0].text;
        String password = _controllers[1].text;
        showDialog(context: context,builder: (BuildContext context) => const Loading());
        authService.signIn(email, password).whenComplete(() => Navigator.popUntil(context, (route) => route.isFirst)).catchError((error, stackTrace) {
          final String errorMessage = error.toString();
          Utils.showSnackBar(text: errorMessage.substring(errorMessage.indexOf(']') + 2, errorMessage.length));
        }).then((value){
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
          width: SizeConfig.isMobile! ?  Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
          height: SizeConfig.isMobile! ? 50 : 60,
          decoration: BoxDecoration(
              color: ProjectColors.transparent,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: mouseProvider!.loginHover ? ProjectColors.customColor : ProjectColors.greyColor, width: 1)),
          child: Center(
            child: ProjectText.rText(
                text: 'Sign In',
                fontSize: 20,
                color: mouseProvider!.loginHover ? ProjectColors.customColor : ProjectColors.greyColor),
          ),
        ),
      ),
    );
  }

  Widget _rememberForgot(BuildContext context) {
    return SizedBox(
      height: 20,
      width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _forgotPass(context),
        _rememberPassLogin(context),
      ]),
    );
  }

  Widget _rememberPassLogin(BuildContext context) {
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
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
    _controllers[0].clear();
    _controllers[1].clear();
  }
}


// login({required BuildContext context, required ModelProvider modelProvider,required MouseProvider mouseProvider, required TextEditingController _controllers[0], required TextEditingController _controllers[1], required FocusNode emailFocus, required FocusNode passwordFocus,formKey}){
//   return SizedBox(
//         width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
//         height: SizeConfig.screenHeight! - Values.barHeight,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//             Space.expandedSpace(),
//             _welcomeText(context),
//             Space.mHeight,
//             Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
//                     child: TextFormField(
//                       focusNode: emailFocus,
//                       validator: (email) => email != null && EmailValidator.validate(email) ? null : 'Enter a valid email',
//                       controller: _controllers[0],
//                       style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
//                       decoration: _inputDecoration('Email'),
//                     ),
//                   ),
//                   Space.sHeight,
//                   SizedBox(
//                     width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
//                     child: TextFormField(
//                         focusNode: passwordFocus,
//                         controller: _controllers[1],
//                         style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
//                         decoration: _inputDecoration('Password')),
//                   ),
//                 ],
//               ),
//             ),
//             Space.sHeight,
//             _rememberForgot(context, mouseProvider),
//             Space.mHeight,
//             _signInButton(context, _controllers[0], _controllers[1], AuthService(), mouseProvider, formKey),
//             Space.mHeight,
//             _doesntHaveAccount(context, mouseProvider, modelProvider),
//             Space.expandedSpace(),
//           ]));
// }

// clear(TextEditingController _controllers[0], TextEditingController _controllers[1]) {
//     _controllers[0].clear();
//     _controllers[1].clear();
//   }

// InputDecoration _inputDecoration(String text) {
//     return InputDecoration(
//         contentPadding: ProjectPadding.horizontalPadding(value: 10),
//         hintText: text,
//         hintStyle: TextStyle(color: ProjectColors.greyColor, fontSize: 14),
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: ProjectColors.greyColor, width: 1),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: ProjectColors.customColor, width: 1),
//         ));
//   }

//   Widget _forgotPass(BuildContext context) {
//     return GestureDetector(
//         onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Forgot())),
//         child: ProjectText.rText(
//             text: 'Forgot Password',
//             fontSize: Values.xSValue,
//             color: Colors.blue,
//             decoration: controller.forgotHover.value ? TextDecoration.underline : TextDecoration.none));
//   }

//   Widget _doesntHaveAccount(BuildContext context, MouseProvider mouseProvider, ModelProvider modelProvider) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ProjectText.rText(text: 'Does not have an account? ', fontSize: Values.xSValue, color: Colors.grey),
//         GestureDetector(
//             onTap: () => modelProvider.toggleSignState(),
//             child: MouseRegion(
//                 cursor: SystemMouseCursors.click,
//                 onEnter: (_) => mouseProvider.toggleDoestHaveAccount(),
//                 onExit: (_) => mouseProvider.toggleDoestHaveAccount(),
//                 child: ProjectText.rText(
//                   text: 'Sign Up',
//                   fontSize: Values.xSValue,
//                   color: Colors.blue,
//                   decoration: mouseProvider.doesntHaveAccount ? TextDecoration.underline : TextDecoration.none,
//                 ))),
//       ],
//     );
//   }

//   Widget _welcomeText(BuildContext context) {
//     return Column(
//       children: [
//         ProjectText.rText(text: 'welogger', fontSize: 35, color: ProjectColors.customColor, fontWeight: FontWeight.bold),
//         Space.mHeight,
//         ProjectText.rText(text: 'login and start to track', fontSize: Values.bigValue, color: ProjectColors.greyColor),
//       ],
//     );
//   }

//   Widget _signInButton(BuildContext context, TextEditingController _controllers[0], TextEditingController _controllers[1], AuthService authService, MouseProvider mouseProvider, formKey) {
//     return GestureDetector(
//       onTap: () {
//         final isValid = formKey.currentState!.validate();
//         if (!isValid) return;
//         String email = _controllers[0].text;
//         String password = _controllers[1].text;
//         showDialog(context: context,builder: (BuildContext context) => const Loading());
//         authService.signIn(email, password).whenComplete(() => Navigator.popUntil(context, (route) => route.isFirst)).catchError((error, stackTrace) {
//           final String errorMessage = error.toString();
//           Utils.showSnackBar(errorMessage.substring(errorMessage.indexOf(']') + 2, errorMessage.length));
//         }).then((value) => value != null ? CookieManager.updateUserCookie(isLogin: true, email: email, password: password) : null);
//         clear(_controllers[0], _controllers[1]);
//       },
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         onEnter: (_) => mouseProvider.toggleLoginHover(),
//         onExit: (_) => mouseProvider.toggleLoginHover(),
//         child: Container(
//           width: SizeConfig.isMobile! ? Values.mobileSignButtonWidth : Values.desktopSignButtonWidth,
//           height: SizeConfig.isMobile! ? Values.mobileSignButtonHeight : Values.desktopSignButtonHeight,
//           decoration: BoxDecoration(
//               color: ProjectColors.transparent,
//               borderRadius: BorderRadius.circular(40),
//               border: Border.all(
//                   color: mouseProvider.loginHover ? ProjectColors.customColor : ProjectColors.greyColor, width: 1)),
//           child: Center(
//             child: ProjectText.rText(
//                 text: 'Sign In',
//                 fontSize: Values.fitValue,
//                 color: mouseProvider.loginHover ? ProjectColors.customColor : ProjectColors.greyColor),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _rememberForgot(BuildContext context, MouseProvider mouseProvider) {
//     return SizedBox(
//       height: 20,
//       width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         _forgotPass(context),
//         _rememberPassLogin(context, mouseProvider),
//       ]),
//     );
//   }

//   Widget _rememberPassLogin(BuildContext context, MouseProvider mouseProvider) {
//     return GestureDetector(
//         onTap: () => mouseProvider.toggleRememberPass(),
//         child: Row(
//           children: [
//             ProjectText.rText(text: 'Remember me', fontSize: Values.xSValue, color: ProjectColors.greyColor),
//             Space.xSWidth,
//             Container(
//                 height: 15,
//                 width: 15,
//                 padding: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                     color: ProjectColors.customColor,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: ProjectColors.themeColorMOD2, width: 1)),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: mouseProvider.rememberPass ? Colors.green : ProjectColors.transparent,
//                       shape: BoxShape.circle),
//                 )),
//           ],
//         ));
//   }





