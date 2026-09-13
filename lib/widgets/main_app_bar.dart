import 'package:classtodoapp/controller/auth_controller.dart';
import 'package:classtodoapp/screens/login_screen.dart';
import 'package:classtodoapp/screens/update_profile_screen.dart';
import 'package:classtodoapp/utils/const.dart';
import 'package:classtodoapp/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSize {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
          );
        },
        child: Row(
          children: [
            ProfileImage(radius: 25,),

            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthController.userData!.firstName} ${AuthController.userData!.lastName}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '${AuthController.userData!.email}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                AuthController.logOutUser();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('LogOut Successfuly')));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInScreen()), ((route) => false));
              },
              icon: Icon(Icons.logout_outlined, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


