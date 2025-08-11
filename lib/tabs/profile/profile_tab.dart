import 'package:evently_app/app_theme.dart';
import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/providers/userProvider.dart';
import 'package:evently_app/tabs/profile/profile_header.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    List<Language> languages = [
      Language(code: 'en', name: 'English'),
      Language(code: 'ar', name: 'العربية'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeader(),
        SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Theme',
                      style: textTheme.titleLarge!.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: settingsProvider.isDark,
                      onChanged: (isdark) {
                        settingsProvider.changeTheme(
                          theme: isdark ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                      activeTrackColor: AppTheme.primary,
                    ),
                  ],
                ),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      'Language',
                      style: textTheme.titleLarge!.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.primary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DropdownButton(
                        value: 'en',
                        items: languages
                            .map(
                              (language) => DropdownMenuItem(
                                value: language.code,
                                child: Text(
                                  language.name,
                                  style: textTheme.titleLarge!.copyWith(
                                    color: AppTheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {},
                        borderRadius: BorderRadius.circular(16),
                        underline: SizedBox(),
                        iconEnabledColor: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    FirebaseService.logOut().then((_) {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(LoginScreen.routeName).then((_) {
                        Provider.of<Userprovider>(
                          context,
                          listen: false,
                        ).updateCurrentUser(null);
                      });
                    });
                  },

                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 24, color: AppTheme.white),
                        SizedBox(width: 8),
                        Text('Logout', style: textTheme.titleLarge),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Language {
  String name;
  String code;
  Language({required this.code, required this.name});
}
