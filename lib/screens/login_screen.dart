import 'package:classtodoapp/controller/auth_controller.dart';
import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/models/user_model.dart';
import 'package:classtodoapp/screens/main_nav_screen.dart';
import 'package:classtodoapp/screens/signup_screen.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:classtodoapp/widgets/screen_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  onTapLogin() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(child: loginBodyUi()),
    );
  }

  Widget loginBodyUi() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * .3),
            Text(
              "Get Started With",
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
            TextFormField(
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
              obscureText: true,
              decoration: InputDecoration(hintText: 'password'),
            ),
            SizedBox(height: 25),
            FilledButton(
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  ApiResponse response = await ApiCaller.postRequest(
                    url: AppUrl.loginUrl,
                    body: {
                      "email": emailController.text,
                      "password": passwordController.text,
                    },
                  );

                  if (response.isScuccess) {
                    UserModel userModel = UserModel.fromJson(
                      response.responseData['data'],
                    );

                     String token = response.responseData['token'];

                    AuthController.saveUserData(userModel, token);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainNavScreen()),
                    );
                  }
                }
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

          TextButton(
            onPressed: () {},
            child: Text(
              'Forget Password ?',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
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
