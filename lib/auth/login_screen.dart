import 'package:evently_app/app_theme.dart';
import 'package:evently_app/auth/register_screen.dart';
import 'package:evently_app/widget/default_elevated_button.dart';
import 'package:evently_app/widget/default_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              hintText: 'Email',
              controller: emailController,
              preFixIconImageName: 'email',
            ),
            SizedBox(height: 16),
            DefaultTextFormField(
              hintText: 'password',
              controller: passwordController,
              preFixIconImageName: 'password',
            ),
            SizedBox(height: 24),
            DefaultElevatedButton(label: 'Login', onPressed: () {}),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('don\'t Have An Account ?',style: textTheme.titleMedium),
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: Text('Create An Account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
