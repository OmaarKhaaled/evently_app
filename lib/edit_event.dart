import 'package:evently_app/app_theme.dart';
import 'package:evently_app/models/category_Model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/tabs/home/tab_item.dart';
import 'package:evently_app/widget/default_elevated_button.dart';
import 'package:evently_app/widget/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  static const String routeName = '/editEvent';

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CategoryModel selectedCategory = CategoryModel.categories.first;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    final EventModel event =
        ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      appBar: AppBar(title: Text('Edit Event')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${event.category.imageName}.png',
                height: screenSize.height * .23,
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
                      selectedForeGroundColor: AppTheme.white,
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
              padding: EdgeInsets.only(left: 16),
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.only(right: 10),
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
                  SizedBox(height: 16),
                  Text('Location', style: textTheme.titleMedium),
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
                                color: AppTheme.white,
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

                  DefaultElevatedButton(
                    label: 'Update Event',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
