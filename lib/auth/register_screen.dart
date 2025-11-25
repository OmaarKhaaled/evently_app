import 'package:evently_app/app_theme.dart';
import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/home_screen.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/providers/userProvider.dart';
import 'package:evently_app/widget/default_elevated_button.dart';
import 'package:evently_app/widget/default_text_form_field.dart';
import 'package:evently_app/widget/firebase_service.dart';
import 'package:evently_app/widget/ui_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                height: MediaQuery.sizeOf(context).height * .2,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 24),
              DefaultTextFormField(
                hintText: AppLocalizations.of(context)!.name,
                controller: nameController,
                preFixIconImageName: 'person',
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return 'Invalid name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              DefaultTextFormField(
                hintText: AppLocalizations.of(context)!.password,
                controller: emailController,
                preFixIconImageName: 'email',
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Invalid Email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DefaultTextFormField(
                hintText: AppLocalizations.of(context)!.password,
                controller: passwordController,
                preFixIconImageName: 'password',
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'password must be at least 8 chars';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 24),
              DefaultElevatedButton(
                label: AppLocalizations.of(context)!.createAccount,
                onPressed: register,
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.already_have_account,
                    style: textTheme.titleMedium!.copyWith(
                      color: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Text(AppLocalizations.of(context)!.login),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseService.register(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          )
          .then((user) {
            Provider.of<Userprovider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            UiUtils.showFaliareMessage(errorMessage);
          });
      ;
    }
  }
}
