import 'package:flutter/material.dart';

class APpConst {
  static String profileImgUrl = "";
 static Color getAvatarColor(String name) {
    final colors = [
      Colors.purple,
      Colors.teal,
      Colors.orange,
      Colors.pink.shade300,
      Colors.green,
      Colors.indigo,   
    ];
final index = name.hashCode % colors.length;
    return colors[index.abs()];
  }

}
