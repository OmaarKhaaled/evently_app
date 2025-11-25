import 'package:evently_app/app_theme.dart';
import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  String label;
  VoidCallback onPressed;

  DefaultElevatedButton({super.key, required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        fixedSize: Size(MediaQuery.sizeOf(context).width, 55),
      ),
      child: Text(label, style: textTheme.titleLarge),
    );
  }
}
