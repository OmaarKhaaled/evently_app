import 'package:evently_app/app_theme.dart';
import 'package:evently_app/models/category_Model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/tabs/home/tab_item.dart';
import 'package:evently_app/widget/default_elevated_button.dart';
import 'package:evently_app/widget/default_text_form_field.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  static const String routeName = '/crete-event';

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CategoryModel selectedCategory = CategoryModel.categories.first;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int currentIndex = 0;
  DateFormat dateFormat = DateFormat('d/M/yyyy');

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    Size screenSize = MediaQuery.sizeOf(context);

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('create Event'),
        backgroundColor: settingsProvider.isDark
            ? AppTheme.backgroundDark
            : AppTheme.backGroundLight,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${selectedCategory.imageName}.png',
                height: screenSize.height * .24,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 16),
          DefaultTabController(
            length: CategoryModel.categories.length,
            child: TabBar(
              tabs: CategoryModel.categories
                  .map(
                    (category) => TabItem(
                      icon: category.icon,
                      label: category.name,
                      isSelected:
                          currentIndex ==
                          CategoryModel.categories.indexOf(category),
                      selectedForeGroundColor: settingsProvider.isDark
                          ? AppTheme.black
                          : AppTheme.white,
                      unselectedForeGroundColor: AppTheme.primary,
                      selectedBackGroundColor: AppTheme.primary,
                    ),
                  )
                  .toList(),
              onTap: (index) {
                if (currentIndex == index) return;
                currentIndex = index;
                selectedCategory = CategoryModel.categories[currentIndex];
                setState(() {});
              },
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.only(right: 10),
              padding: EdgeInsets.only(left: 16),
              tabAlignment: TabAlignment.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: textTheme.titleMedium!.copyWith(
                      color: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  DefaultTextFormField(
                    hintText: 'Event Title',
                    preFixIconImageName: 'title',
                    controller: titleEditingController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title can not be null';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'description',
                    style: textTheme.titleMedium!.copyWith(
                      color: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  DefaultTextFormField(
                    hintText: 'Event description',
                    controller: descriptionEditingController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description can not be null';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/date.svg',
                        colorFilter: ColorFilter.mode(
                          settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Event Date',
                        style: textTheme.titleMedium!.copyWith(
                          color: settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                          );
                          if (dateTime != null) {
                            selectedDate = dateTime;
                            setState(() {});
                          }
                        },
                        child: Text(
                          selectedDate == null
                              ? 'Select Date'
                              : dateFormat.format(selectedDate!),
                          style: textTheme.titleMedium!.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/time.svg',
                        colorFilter: ColorFilter.mode(
                          settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Event Time',
                        style: textTheme.titleMedium!.copyWith(
                          color: settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            selectedTime = time;
                            setState(() {});
                          }
                        },
                        child: Text(
                          selectedTime == null
                              ? 'choose Time'
                              : selectedTime!.format(context),
                          style: textTheme.titleMedium!.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  DefaultElevatedButton(
                    label: 'Add Event',
                    onPressed: createEvent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createEvent() {
    if (formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      EventModel event = EventModel(
        Userid: FirebaseAuth.instance.currentUser!.uid,
        category: selectedCategory,
        title: titleEditingController.text,
        dateTime: dateTime,
        description: descriptionEditingController.text,
      );
      FirebaseService.createEvent(event).then((_) {
        Navigator.of(context).pop();
      });
    }
  }
}
