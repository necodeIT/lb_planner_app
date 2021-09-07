import 'package:flutter/material.dart';
import 'package:lb_planner/ui.dart';

class SettingsGeneralItem extends StatelessWidget {
  SettingsGeneralItem({Key? key, required this.icon, this.fontsize = 20, this.height = 30, this.width = 30, required this.text, required this.onTap});

  final String text;
  final IconData icon;
  final double? fontsize;
  final double? height;
  final double? width;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: NcCaptionText(
            text,
            fontSize: fontsize,
          ),
        ),
        NcSpacing.small(),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            decoration: new BoxDecoration(
              color: NcThemes.current.secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(ncRadius)),
            ),
            child: Center(
              child: Icon(
                icon,
                color: NcThemes.current.textColor,
                size: fontsize,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
