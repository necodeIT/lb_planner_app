import 'package:flutter/material.dart';
import 'package:lb_planner/ui.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem({Key? key, required this.icon, required this.isSelected, required this.onTap}) : super(key: key);

  final IconData icon;
  final bool isSelected;
  final Function() onTap;

  static const double padding = 10;
  static const double radius = 16;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelected ? null : onTap,
      child: Container(
        margin: EdgeInsets.only(top: NcSpacing.smallSpacing),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          color: isSelected ? NcThemes.current.accentColor : NcThemes.current.secondaryColor,
          boxShadow: isSelected ? ncShadow : null,
        ),
        child: Icon(
          icon,
          color: isSelected ? NcThemes.current.buttonTextColor : NcThemes.current.textColor,
        ),
      ),
    );
  }
}