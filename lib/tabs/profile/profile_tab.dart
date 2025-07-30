import 'package:evently_app/app_theme.dart';
import 'package:evently_app/tabs/profile/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<Language> languages = [
      Language(code: 'en', name: 'English'),
      Language(code: 'ar', name: 'العربية'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeader(),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language',
                style: textTheme.titleLarge!.copyWith(
                  color: AppTheme.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
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
                  isExpanded: true,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Theme',
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                    activeTrackColor: AppTheme.primary,
                  ),
                ],
              ),
            ],
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
