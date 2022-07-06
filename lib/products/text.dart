import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectText {

  Text linkText(text,color,weight,decColor,) => Text(text,style: TextStyle(color: color,decoration: TextDecoration.underline,decorationColor: decColor,decorationThickness: 1,decorationStyle:TextDecorationStyle.solid,fontSize: 10,),textAlign: TextAlign.center,);
  static Text rText(
          {required String text,
          required double fontSize,
          Color? color = Colors.white,
          FontWeight? fontWeight = FontWeight.w300,
          double? letterSpacing = 0,
          TextDecoration? decoration = TextDecoration.none,
          int? maxLines = 10,
          TextAlign? textAlign = TextAlign.center}) =>
      Text(text,maxLines: maxLines, textAlign: textAlign,
          style: GoogleFonts.raleway(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              decoration: decoration,));
              
}
