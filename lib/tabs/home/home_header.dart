import 'package:evently_app/app_theme.dart';
import 'package:evently_app/models/category_Model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/providers/event_provider.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/providers/userProvider.dart';
import 'package:evently_app/tabs/home/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of(context);
    UserModel user = Provider.of<Userprovider>(context).currentUser!;
    EventProvider eventProvider = Provider.of<EventProvider>(context);

    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 16),
      decoration: BoxDecoration(
        color: settingsProvider.isDark
            ? AppTheme.backgroundDark
            : AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back 😍', style: textTheme.titleSmall),
            Text(user.name, style: textTheme.headlineSmall),
            SizedBox(height: 16),
            DefaultTabController(
              length: CategoryModel.categories.length + 1,
              child: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.only(right: 10),
                onTap: (index) {
                  if (currentIndex == index) return;
                  currentIndex = index;
                  setState(() {});
                  CategoryModel? selectedCategory = currentIndex == 0
                      ? null
                      : CategoryModel.categories[currentIndex - 1];
                  eventProvider.filterEvents(selectedCategory);
                },
                tabs: [
                  TabItem(
                    icon: Icons.ac_unit_outlined,
                    label: 'All',
                    isSelected: currentIndex == 0,
                    selectedForeGroundColor: settingsProvider.isDark
                        ? AppTheme.white
                        : AppTheme.primary,
                    unselectedForeGroundColor: AppTheme.white,
                    selectedBackGroundColor: settingsProvider.isDark
                        ? AppTheme.primary
                        : AppTheme.white,
                  ),
                  ...CategoryModel.categories.map(
                    (category) => TabItem(
                      icon: category.icon,
                      label: category.name,
                      isSelected:
                          currentIndex ==
                          CategoryModel.categories.indexOf(category) + 1,
                      selectedForeGroundColor: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.primary,
                      unselectedForeGroundColor: AppTheme.white,
                      selectedBackGroundColor: settingsProvider.isDark
                          ? AppTheme.primary
                          : AppTheme.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
