import 'package:evently_app/widget/default_text_form_field.dart';
import 'package:evently_app/widget/event_item.dart';
import 'package:flutter/material.dart';

class LoveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DefaultTextFormField(
              hintText: 'Search for Event',
              preFixIconImageName: 'search',
              onChanged: (quary) {},
            ),
          ),
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
      ),
    );
    ;
  }
}
