import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String imageName;
  IconData icon;

  CategoryModel({
    required this.id,
    required this.icon,
    required this.imageName,
    required this.name,
  });

static List<CategoryModel> categories = [
    CategoryModel(
      icon: Icons.sports_baseball_outlined,
      id: '1',
      imageName: 'sport',
      name: 'sport',
    ),
    CategoryModel(
      icon: Icons.cake_outlined,
      id: '2',
      imageName: 'birthday',
      name: 'BirthDay',
    ),
    CategoryModel(
      icon: Icons.more_time,
      id: '3',
      imageName: 'meeting',
      name: 'meeting',
    ),
  ];
}
