import 'package:evently_app/models/category_Model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favoriteEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }
    notifyListeners();
  }

  void favouriteFilterEvents(List<String> favouriteIds) {
    favoriteEvents = allEvents
        .where((event) => favouriteIds.contains(event.id))
        .toList();
    notifyListeners();
  }
}
