import 'package:classtodoapp/screens/login_screen.dart';
import 'package:classtodoapp/widgets/screen_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * .15),
          Text("Join With Us", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 20),
          TextFormField(decoration: InputDecoration(hintText: 'Email')),
          SizedBox(height: 15),
          TextFormField(decoration: InputDecoration(hintText: 'First Name')),
          SizedBox(height: 15),
          TextFormField(decoration: InputDecoration(hintText: 'Last Name')),
          SizedBox(height: 15),
          TextFormField(decoration: InputDecoration(hintText: 'Mobile')),
          SizedBox(height: 15),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(hintText: 'password'),
          ),
          SizedBox(height: 25),
          FilledButton(
            onPressed: () {},
            child: Icon(Icons.navigate_next_outlined, size: 22),
          ),
          forgotText(),
        ],
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
