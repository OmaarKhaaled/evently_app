import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarIcon extends StatelessWidget {
  String IconName;
  NavBarIcon({required this.IconName});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$IconName.svg',
      width: 24,
      height: 24,
      fit: BoxFit.scaleDown,
    );
  }
}
