import 'package:evently_app/models/category_Model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/tabs/home/home_header.dart';
import 'package:evently_app/widget/event_item.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> AllEvents = [];
  List<EventModel> displayedEvents = [];

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(filterEvents: filterEvents),
        SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) =>
                EventItem(event: displayedEvents[index]),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: displayedEvents.length,
          ),
        ),
      ],
    );
  }

  Future<void> getEvents() async {
    AllEvents = await FirebaseService.getEvents();
    displayedEvents = AllEvents;
    setState(() {});
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = AllEvents;
    } else {
      displayedEvents = AllEvents.where(
        (event) => event.category == category,
      ).toList();
    }
    setState(() {});
  }
}
