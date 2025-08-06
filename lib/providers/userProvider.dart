import 'package:evently_app/models/user_model.dart';
import 'package:flutter/material.dart';

class Userprovider with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}
