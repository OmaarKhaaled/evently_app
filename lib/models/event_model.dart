import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/category_Model.dart';

class EventModel {
  String id;
  String title;
  String description;
  DateTime dateTime;
  CategoryModel category;

  EventModel({
    this.id = '',
    required this.category,
    required this.title,
    required this.dateTime,
    required this.description,
  });

  EventModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        title: json['title'],
        category: CategoryModel.categories.firstWhere(
          (category) => category.id == json['categoryID'],
        ),
        dateTime: (json['timeStamp'] as Timestamp).toDate(),
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'categoryID': category.id,
    'timeStamp': Timestamp.fromDate(dateTime),
  };
}
