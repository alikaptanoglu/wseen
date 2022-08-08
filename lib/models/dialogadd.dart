import 'dart:ui';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_pickers/countries.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/loading.dart';
import 'package:wseen/models/utils.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';
import 'package:wseen/services/firestore.dart';

class DialogAdd extends StatefulWidget {
  const DialogAdd({Key? key}) : super(key: key);

  @override
  State<DialogAdd> createState() => _DialogAddState();
}

class _DialogAddState extends State<DialogAdd> {

  DbService dbService = DbService();
  BuildContext? loadingContext;

  final FocusNode numberFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {

    _nameController.addListener(() { 
      Provider.of<FieldProvider>(context, listen: false).getIsNameFieldEmpty(_nameController.text.isEmpty);
    });

    _numberController.addListener(() { 
      Provider.of<FieldProvider>(context, listen: false).getIsNumberFieldEmpty(_numberController.text.isEmpty);
    });

    nameFocus.unfocus();
    numberFocus.requestFocus();

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Provider.of<FieldProvider>(context, listen: false).setFieldState(0);
        clear();
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! < 350 ? 10 : 20),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: ProjectColors.transparent,
        elevation: 0,
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Consumer<FieldProvider>(
            builder: (context, value, child) {
              return  IndexedStack(
                index: value.fieldState,
                children: [
                  phoneState(),
                  nameState(),
                ],
              );
            },
          )
        ),
      ),
    );
  }

  Widget phoneState() {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    null;
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 500),
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.withOpacity(0.5),Colors.blue.withOpacity(0.5)], begin: Alignment.topLeft, end: Alignment.bottomRight),borderRadius: BorderRadius.circular(12)),padding: const EdgeInsets.all(2),
                    child: Container(padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! < 350 ? 5 : 20), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: const Color.fromARGB(255, 30, 30, 30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              constraints: const BoxConstraints(minWidth: 70),
                              child: CountryCodePicker(
                                initialSelection: WidgetsBinding.instance.window.locales.first.countryCode,
                                onChanged: (value) => Provider.of<ModelProvider>(context, listen: false).setDialCode(value.dialCode!),
                                hideMainText: true,
                                flagWidth: 40,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            Consumer<ModelProvider>(
                              builder:(context, value, child) {
                                return FittedBox(child: Text(value.dialCode!, style: GoogleFonts.roboto(fontSize: SizeConfig.screenWidth! < 350 ? 18 : 22, color: const Color.fromARGB(255, 230, 230, 230), fontWeight: FontWeight.bold)));
                              },
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  maxLength: 30,
                                  focusNode: numberFocus,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                  controller: _numberController,
                                  style: TextStyle(color: Colors.white, fontSize: SizeConfig.screenWidth! < 350 ? 18 : 22),
                                  decoration: inputDecoration(),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Space.sHeight,
                GestureDetector(
                  onTap: () {
                    if(_numberController.text.isEmpty) return;
                    numberFocus.unfocus();
                    nameFocus.requestFocus();
                    Provider.of<FieldProvider>(context, listen: false).setFieldState(1);
                  },
                  child: button('CONTINUE', Provider.of<FieldProvider>(context, listen: false).isNumberFieldEmpty),
                ),
              ],
            );
  }

  Widget nameState() {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    null;
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 500),
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.withOpacity(0.5),Colors.blue.withOpacity(0.5)], begin: Alignment.topLeft, end: Alignment.bottomRight),borderRadius: BorderRadius.circular(12)),padding: const EdgeInsets.all(2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: const Color.fromARGB(255, 30, 30, 30)),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name: ', style: TextStyle(color: ProjectColors.themeColorMOD2, fontSize: 24)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  maxLength: 40,
                                  style: TextStyle(color: ProjectColors.customColor, fontSize: 24),
                                  focusNode: nameFocus,
                                  controller: _nameController,
                                  decoration: inputDecoration(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Space.sHeight,
                GestureDetector(
                  onTap: () {
                    if(_nameController.text.isEmpty) return;
                    nameFocus.unfocus();
                    Provider.of<FieldProvider>(context, listen: false).setFieldState(0);
                    String dialCode = Provider.of<ModelProvider>(context, listen: false).dialCode!.replaceAll('+', '');
                    String number = dialCode + _numberController.text;
                    String name = _nameController.text;
                    Navigator.of(context).pop();
                    showDialog(context: context, builder: (context) {
                      loadingContext = context;
                      return const Loading();
                    });
                    dbService.addContactToDatabase(FirebaseAuth.instance.currentUser!.uid, number, name).whenComplete(() => Navigator.of(loadingContext!).pop()).catchError((error){
                    Utils.showSnackBar(text: error.toString());
                    });
                  },
                  child: button('ADD', Provider.of<FieldProvider>(context, listen: false).isNameFieldEmpty),
                ),
              ],
            );
  }

  Container button(String text, isEmpty) {
    return Container(
                width: SizeConfig.screenWidth,
                constraints: const BoxConstraints(maxWidth: 500),
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: ProjectColors.themeColorMOD3,
                  borderRadius: BorderRadius.circular(12), 
                  border: Border.all(color: isEmpty ? ProjectColors.greyColor : ProjectColors.customColor, width: 2)),
                child: Center(
                  child: ProjectText.rText(
                    text: text,
                    fontSize: 24,
                    color: isEmpty ? ProjectColors.greyColor : ProjectColors.customColor, fontWeight: FontWeight.bold)),
              );
  }

  InputDecoration inputDecoration(){
    return InputDecoration(
        counterText: '',
        contentPadding: const EdgeInsets.all(0),
        isDense: true,
        hintStyle: TextStyle(color: ProjectColors.greyColor, fontSize: 14),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
    );
}
  clear(){
    _nameController.clear();
    _numberController.clear();
    String dialCode = '+${countryList.where((element) => element.isoCode == WidgetsBinding.instance.window.locales.first.countryCode).first.phoneCode}';
    Provider.of<ModelProvider>(context, listen: false).setDialCode(dialCode);
  }
}
