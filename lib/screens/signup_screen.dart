import 'dart:convert';

import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/screens/login_screen.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:classtodoapp/widgets/screen_background.dart';
import 'package:classtodoapp/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  onTapSignUp() async {
    final ApiResponse response = await ApiCaller.postRequest(
      url: AppUrl.signUpUrl,
      body: {
        "email": emailController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "mobile": mobileController.text,
        "password": passwordController.text,
      },
    );
    if (response.isScuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ScreenBackground(child: signUpBodyUi()),
    );
  }

  Widget signUpBodyUi() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * .15),
            Text("Join With Us", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Enter a valid Email Address';
                }
                return null;
              },
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(height: 15),
            InputField(hintText: 'FirstName', controller: firstNameController),
            SizedBox(height: 15),
            InputField(hintText: 'LasName', controller: lastNameController),
            SizedBox(height: 15),
            InputField(hintText: 'Mobile', controller: mobileController),
            SizedBox(height: 15),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password Is required';
                }
                if (value.length < 8) {
                  return 'Password length atleast 8';
                }
                if (value.length > 15) {
                  return 'Password length atlmost 15';
                }
                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return 'Password must contain an uppercase letter';
                }
                if (!RegExp(r'[a-z]').hasMatch(value)) {
                  return 'Password must contain a lowercase letter';
                }
                if (!RegExp(r'[0-9]').hasMatch(value)) {
                  return 'Password must contain a number';
                }
                if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                  return 'Password must contain a special character';
                }
                return null;
              },
              decoration: InputDecoration(hintText: 'password'),
            ),
            SizedBox(height: 25),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Form Is valid')));
                }

                onTapSignUp();
              },
              child: Icon(Icons.navigate_next_outlined, size: 22),
            ),
            forgotText(),
          ],
        ),
      ),
    );
  }

  Widget forgotText() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInScreen()),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
