import 'package:evently_app/app_theme.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DefaultTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? preFixIconImageName;
  String? Function(String?)? validator;
  bool isPassword;

  DefaultTextFormField({super.key, 
    required this.hintText,
    this.controller,
    this.onChanged,
    this.preFixIconImageName,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return TextFormField(
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: settingsProvider.isDark ? AppTheme.white : AppTheme.black,
      ),

      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.preFixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/${widget.preFixIconImageName}.svg',
                fit: BoxFit.scaleDown,
              ),
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () {
                  isObscure = !isObscure;
                  setState(() {});
                },

                child: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.grey,
                ),
              )
            : null,
      ),
      obscureText: isObscure,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus!.unfocus(),
    );
  }
}
