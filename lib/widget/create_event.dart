import 'package:evently_app/app_theme.dart';
import 'package:evently_app/models/category_Model.dart';
import 'package:evently_app/tabs/home/tab_item.dart';
import 'package:evently_app/widget/default_elevated_button.dart';
import 'package:evently_app/widget/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateEvent extends StatefulWidget {
  static const String routeName = '/crete-event';

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    int currentIndex = 0;

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('create Event')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/sport.png',
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
                      selectedForeGroundColor: AppTheme.white,
                      unselectedForeGroundColor: AppTheme.primary,
                      selectedBackGroundColor: AppTheme.primary,
                    ),
                  )
                  .toList(),
              onTap: (index) {
                if (index == currentIndex) return;
                currentIndex = index;
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
                  Text('Title', style: textTheme.titleMedium),
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
                  Text('description', style: textTheme.titleMedium),
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
                      SvgPicture.asset('assets/icons/date.svg'),
                      SizedBox(width: 8),
                      Text('Event Date', style: textTheme.titleMedium),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                          );
                        },
                        child: Text(
                          'Select Date',
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
                      SvgPicture.asset('assets/icons/time.svg'),
                      SizedBox(width: 8),
                      Text('Event Time', style: textTheme.titleMedium),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          TimeOfDay? day = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                        },
                        child: Text(
                          'Select Time',
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
    if (formKey.currentState!.validate()) {}
  }
}
