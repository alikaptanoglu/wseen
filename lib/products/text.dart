import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectText {

  Text linkText(text,color,weight,decColor,) => Text(text,style: TextStyle(color: color,decoration: TextDecoration.underline,decorationColor: decColor,decorationThickness: 1,decorationStyle:TextDecorationStyle.solid,fontSize: 10),textAlign: TextAlign.center,);
  static Text rText(
          {required String text,
          required double fontSize,
          Color? color = Colors.white,
          FontWeight? fontWeight = FontWeight.w300,
          double? letterSpacing = 0,
          TextDecoration? decoration = TextDecoration.none,
          int? maxLines = 10,
          TextAlign? textAlign = TextAlign.center, double? height, TextAlignVertical? textAlignVertical = TextAlignVertical.center}) =>
      Text(text,maxLines: maxLines, textAlign: textAlign,
          style: GoogleFonts.raleway(
              height: height,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              decoration: decoration,));
              
}


class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}