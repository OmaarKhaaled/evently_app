import 'package:evently_app/app_theme.dart';
import 'package:evently_app/tabs/home/home_header.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(children: [
      HomeHeader()
    ],);
  }
}
