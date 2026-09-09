import 'package:classtodoapp/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPath.backgroundImgPath,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
