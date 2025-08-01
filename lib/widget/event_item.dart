import 'package:evently_app/app_theme.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  EventModel event;
  EventItem({required this.event});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/${event.category.imageName}.png',
              height: screenSize.height * .23,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppTheme.white,
            ),
            child: Column(
              children: [
                Text(
                  '${event.dateTime.day}',
                  style: textTheme.titleLarge!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('MMM').format(event.dateTime),
                  style: textTheme.titleSmall!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                width: screenSize.width - 32,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        event.title,
                        style: textTheme.titleSmall!.copyWith(
                          color: AppTheme.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(
                        size: 25,
                        Icons.favorite_rounded,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
