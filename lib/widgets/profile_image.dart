import 'package:classtodoapp/controller/auth_controller.dart';
import 'package:classtodoapp/utils/const.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double radius;
  const ProfileImage({super.key,required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: APpConst.profileImgUrl.isEmpty
          ? Colors.pink.shade200
          : null,
      backgroundImage: APpConst.profileImgUrl.isNotEmpty
          ? NetworkImage(APpConst.profileImgUrl)
          : null,
      child: APpConst.profileImgUrl.isEmpty
          ? Text(
              "${AuthController.userData!.firstName![0].toUpperCase()}${AuthController.userData!.lastName![0].toUpperCase()}",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          : null,
    );
  }
}
