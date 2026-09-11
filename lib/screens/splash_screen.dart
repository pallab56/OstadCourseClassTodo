import 'package:classtodoapp/controller/auth_controller.dart';
import 'package:classtodoapp/screens/login_screen.dart';
import 'package:classtodoapp/screens/main_nav_screen.dart';
import 'package:classtodoapp/utils/asset_path.dart';
import 'package:classtodoapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 1));

    // print(AuthController.token);
    // print(AuthController.userData);

    AuthController.getUserData();
    bool isLogin = await AuthController.isUserLogin();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>isLogin?MainNavScreen() : LogInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Image.asset(AssetPath.logoImagePath, width: 300, height: 300),
        ),
      ),
    );
  }
}
