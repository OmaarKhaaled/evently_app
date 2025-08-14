import 'package:evently_app/event_details.dart';
import 'package:evently_app/providers/event_provider.dart';
import 'package:evently_app/tabs/home/home_header.dart';
import 'package:evently_app/widget/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<EventProvider>(context, listen: false).getEvents();
    });
  }

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
            itemBuilder: (context, index) {
              final event = eventProvider.displayedEvents[index];
              return GestureDetector(
                onTap: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    EventDetails.routeName,
                    arguments: event,
                  );
                  if (result == true) {
                    Provider.of<EventProvider>(
                      context,
                      listen: true,
                    ).getEvents();
                  }
                },
                child: EventItem(event: event),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: eventProvider.displayedEvents.length,
          ),
        ),
      ],
    );
  }
}
