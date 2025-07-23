import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? preFixIconImageName;
  String? Function(String?)? validator ;

  DefaultTextFormField({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.preFixIconImageName,
    this.validator
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: preFixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/$preFixIconImageName.svg',
                fit: BoxFit.scaleDown,
              ),
      ),
      validator: validator,
    );
  }
}
