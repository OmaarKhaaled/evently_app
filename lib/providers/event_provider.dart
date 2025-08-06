import 'package:evently_app/models/category_Model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> AllEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favoriteEvents = [];

  Future<void> getEvents() async {
    AllEvents = await FirebaseService.getEvents();
    displayedEvents = AllEvents;
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = AllEvents;
    } else {
      displayedEvents = AllEvents.where(
        (event) => event.category == category,
      ).toList();
    }
    notifyListeners();
  }

  void favouriteFilterEvents(List<String> favouriteIds) {
    favoriteEvents = AllEvents.where(
      (event) => favouriteIds.contains(event.id),
    ).toList();
    notifyListeners();
  }
}
