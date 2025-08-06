import 'package:evently_app/providers/event_provider.dart';
import 'package:evently_app/tabs/home/home_header.dart';
import 'package:evently_app/widget/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    return Column(
      children: [
        HomeHeader(),
        SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) =>
                EventItem(event: eventProvider.displayedEvents[index]),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: eventProvider.displayedEvents.length,
          ),
        ),
      ],
    );
  }
}
