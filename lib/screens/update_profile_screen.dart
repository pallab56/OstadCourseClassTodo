import 'package:classtodoapp/controller/auth_controller.dart';
import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/models/user_model.dart';
import 'package:classtodoapp/screens/main_nav_screen.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:classtodoapp/widgets/main_app_bar.dart';
import 'package:classtodoapp/widgets/screen_background.dart';
import 'package:classtodoapp/widgets/text_field.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> updateProfile() async {
    Map<String, dynamic> requestBody = {
      "email": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "mobile": mobileController.text,
    };
    if (passwordController.text.isNotEmpty) {
      requestBody['password'] = 'passwordController.text';
    }
    final ApiResponse response = await ApiCaller.postRequest(
      url: AppUrl.updateProfileUrl,
      body: requestBody,
    );
    if (response.isScuccess) {
      UserModel model = UserModel(
        sId: AuthController.userData?.sId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text,
        email: emailController.text,
      );
      AuthController.updateUserData(model);
      setState(() {});

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainNavScreen()),
        (route) =>
            false, 
      );
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.text = AuthController.userData!.email.toString();
    firstNameController.text = AuthController.userData!.firstName.toString();
    lastNameController.text = AuthController.userData!.lastName.toString();
    mobileController.text = AuthController.userData!.mobile.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MainAppBar(),
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
            Text(
              "Update Profile",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              validator: (value) {
                // if (value == null || value.isEmpty) {
                //   return 'Email is required';
                // }
                // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                // if (!emailRegex.hasMatch(value)) {
                //   return 'Enter a valid Email Address';
                // }
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
                // if (value == null || value.isEmpty) {
                //   return 'Password Is required';
                // }
                // if (value.length < 8) {
                //   return 'Password length atleast 8';
                // }
                // if (value.length > 15) {
                //   return 'Password length atlmost 15';
                // }
                // if (!RegExp(r'[A-Z]').hasMatch(value)) {
                //   return 'Password must contain an uppercase letter';
                // }
                // if (!RegExp(r'[a-z]').hasMatch(value)) {
                //   return 'Password must contain a lowercase letter';
                // }
                // if (!RegExp(r'[0-9]').hasMatch(value)) {
                //   return 'Password must contain a number';
                // }
                // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                //   return 'Password must contain a special character';
                // }
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
                  updateProfile();
                  setState(() {});
                }
              },
              child: Icon(Icons.navigate_next_outlined, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
