import 'package:evently_app/app_theme.dart';
import 'package:evently_app/edit_event.dart';
import 'package:evently_app/home_screen.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  static const String routeName = 'eventDetails';

  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('d MMMM yyyy');
    DateFormat timeFormat = DateFormat('hh:mm a');
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    final EventModel event =
        ModalRoute.of(context)!.settings.arguments as EventModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        leading: InkWell(
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName),
          child: Icon(Icons.arrow_back, size: 26),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                EditEvent.routeName,
                arguments: event,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(Icons.edit),
            ),
          ),
          InkWell(
            onTap: () async {
              bool? confirm = await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    'Confirm Delete',
                    style: textTheme.headlineSmall!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  content: Text(
                    'Are you sure you want to delete this event?',
                    style: textTheme.titleMedium!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.pop(ctx, false),
                    ),
                    TextButton(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await FirebaseService.deleteEvent(event.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Event deleted successfully',
                      style: textTheme.titleMedium!.copyWith(
                        color: AppTheme.white,
                      ),
                    ),
                    backgroundColor: AppTheme.red,
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.delete, color: AppTheme.red),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.asset(
                    'assets/images/${event.category.imageName}.png',
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * .25,
                  ),
                ),
                SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: textTheme.headlineSmall!.copyWith(
                        color: AppTheme.primary,
                      ),
                    ),
                    SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.primary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/icons/date.svg',
                                  width: 20,
                                  height: 26,
                                  colorFilter: ColorFilter.mode(
                                    settingsProvider.isDark
                                        ? AppTheme.black
                                        : AppTheme.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dateFormat.format(event.dateTime),
                                style: textTheme.titleMedium!.copyWith(
                                  color: AppTheme.primary,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                timeFormat.format(event.dateTime),
                                style: textTheme.titleMedium!.copyWith(
                                  color: settingsProvider.isDark
                                      ? AppTheme.white
                                      : AppTheme.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.primary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.my_location,
                                  color: settingsProvider.isDark
                                      ? AppTheme.black
                                      : AppTheme.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  'cairo , Egypt',
                                  style: textTheme.titleLarge!.copyWith(
                                    color: AppTheme.primary,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: AppTheme.primary,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      'assets/images/map.png',
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error, color: Colors.red, size: 64),
                    ),
                    SizedBox(height: 16),

                    Text(
                      'Description',
                      style: textTheme.titleLarge!.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      event.description,
                      style: textTheme.titleMedium!.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
