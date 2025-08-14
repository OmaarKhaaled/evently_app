import 'package:evently_app/app_theme.dart';
import 'package:evently_app/event_details.dart';
import 'package:evently_app/models/category_Model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/tabs/home/tab_item.dart';
import 'package:evently_app/widget/default_elevated_button.dart';
import 'package:evently_app/widget/default_text_form_field.dart';
import 'package:evently_app/widget/firebase_service.dart';
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
  late TextEditingController titleEditingController;
  late TextEditingController descriptionEditingController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late CategoryModel selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');

  int currentIndex = 0;
  bool isInitialized = false;
  late EventModel event;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      event = ModalRoute.of(context)!.settings.arguments as EventModel;
      titleEditingController = TextEditingController(text: event.title);
      descriptionEditingController = TextEditingController(
        text: event.description,
      );

      selectedCategory = event.category;
      currentIndex = CategoryModel.categories.indexOf(selectedCategory);

      selectedDate = event.dateTime;
      selectedTime = TimeOfDay.fromDateTime(event.dateTime);

      isInitialized = true;
    }
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Event')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/${selectedCategory.imageName}.png',
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
                  setState(() {
                    currentIndex = index;
                    selectedCategory = CategoryModel.categories[index];
                  });
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
                      'Description',
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
                            DateTime today = DateTime.now();

                            DateTime? dateTime = await showDatePicker(
                              context: context,
                              firstDate: today,
                              lastDate: today.add(Duration(days: 365)),
                              initialDate:
                                  (selectedDate != null &&
                                      selectedDate!.isAfter(today))
                                  ? selectedDate!
                                  : today,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );

                            if (dateTime != null) {
                              setState(() {
                                selectedDate = dateTime;
                              });
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
                              initialTime: selectedTime ?? TimeOfDay.now(),
                            );
                            if (time != null) {
                              setState(() {
                                selectedTime = time;
                              });
                            }
                          },
                          child: Text(
                            selectedTime == null
                                ? 'Choose Time'
                                : selectedTime!.format(context),
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Location',
                      style: textTheme.titleMedium!.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
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
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            selectedDate != null &&
                            selectedTime != null) {
                          DateTime updatedDateTime = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          );

                          EventModel updatedEvent = EventModel(
                            id: event.id,
                            Userid: event.Userid,
                            category: selectedCategory,
                            title: titleEditingController.text,
                            dateTime: updatedDateTime,
                            description: descriptionEditingController.text,
                          );

                          FirebaseService.updateEvent(updatedEvent).then((_) {
                            Navigator.of(context).pushReplacementNamed(
                              EventDetails.routeName,
                              arguments: updatedEvent,
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
