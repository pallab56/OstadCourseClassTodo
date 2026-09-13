import 'package:flutter/material.dart';

class TaskCardCount extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  const TaskCardCount({super.key, required this.title, required this.count,required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 130,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count.toString(),
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
