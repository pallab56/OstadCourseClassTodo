import 'package:classtodoapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ScreenBackground(child: loginBodyUi()));
  }

  Widget loginBodyUi() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * .3),
          Text(
            "Get Started With",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20),
          TextFormField(decoration: InputDecoration(hintText: 'Email')),
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
          SizedBox(height: 50,
         ),
          
          TextButton(
            onPressed: () {
              
            },
            child: Text('Forget Password ?',
              style: TextStyle(color: Colors.grey,
              fontWeight: FontWeight.w500
              )) ),
         
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            children: [
              TextSpan(text: "Don't have an account? ",
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.w700
              )),
              TextSpan(text: 'Sign Up',
              style: TextStyle(color: Colors.green,
              fontWeight: FontWeight.w700
              )),
            ]
          )),
        ],
      ),
    );
  }
}
