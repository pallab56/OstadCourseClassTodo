import 'package:classtodoapp/controller/auth_controller.dart';
import 'package:classtodoapp/screens/update_profile_screen.dart';
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
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
              ),
            ),

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
