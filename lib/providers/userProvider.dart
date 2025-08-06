import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:flutter/material.dart';

class Userprovider with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  void addEventToFavorite(String eventId) {
    FirebaseService.addEventToFavorites(eventId);
    currentUser!.favoriteEventsIds.add(eventId);
    notifyListeners();
  }

  void removeEventfromFavorite(String eventId) {
    FirebaseService.addEventToFavorites(eventId);
    currentUser!.favoriteEventsIds.remove(eventId);
    notifyListeners();
  }

  bool isFavoriteEvent(String eventId) {
    return currentUser!.favoriteEventsIds.contains(eventId);
  }
}
