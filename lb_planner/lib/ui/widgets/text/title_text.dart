import 'package:flutter/material.dart';
import 'package:lb_planner/ui.dart';

// ignore: camel_case_types
class NcTitleText extends StatelessWidget {
  const NcTitleText(this.text, {Key? key, this.fontSize, this.buttonText = false, this.overflow = TextOverflow.ellipsis, this.textAlign = TextAlign.left}) : super(key: key);

  final String text;
  final double? fontSize;
  final bool buttonText;
  final TextOverflow overflow;
  final TextAlign textAlign;

  static TextStyle get baseStyle {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: NcThemes.current.textColor);
  }

  static TextStyle style({double? fontSize, buttonText = false}) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: buttonText ? NcThemes.current.buttonTextColor : NcThemes.current.textColor);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style(fontSize: fontSize, buttonText: buttonText),
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
