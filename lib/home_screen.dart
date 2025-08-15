import 'package:evently_app/app_theme.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/nav_bar_icon.dart';
import 'package:evently_app/tabs/home/home_tab.dart';
import 'package:evently_app/tabs/love/love_tab.dart';
import 'package:evently_app/tabs/map/map_tab.dart';
import 'package:evently_app/tabs/profile/profile_tab.dart';
import 'package:evently_app/widget/create_event.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        color: AppTheme.primary,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndex,

          onTap: (index) {
            if (currentIndex == index) return;
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: NavBarIcon(IconName: 'home'),
              activeIcon: NavBarIcon(IconName: 'home_active'),
              label: AppLocalizations.of(context)?.home ?? 'Home',
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(IconName: 'map'),
              activeIcon: NavBarIcon(IconName: 'map_active'),
              label: AppLocalizations.of(context)?.map ?? 'Map',
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(IconName: 'love'),
              activeIcon: NavBarIcon(IconName: 'love_active'),
              label: AppLocalizations.of(context)?.love ?? 'Love',
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(IconName: 'profile'),
              activeIcon: NavBarIcon(IconName: 'profile_active'),
              label: AppLocalizations.of(context)?.profile ?? 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateEvent.routeName);
        },
        child: Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
