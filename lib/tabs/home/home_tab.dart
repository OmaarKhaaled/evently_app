import 'package:evently_app/tabs/home/home_header.dart';
import 'package:evently_app/widget/event_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(),
        SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => EventItem(),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
