import 'package:flutter/material.dart';

class TaskCardCount extends StatelessWidget {
  final String title;
  final int count;
  const TaskCardCount({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) =>Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
            Text(count.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            
            ]),
        ),
      ),
        separatorBuilder: (context, index) => SizedBox(width: 7,),
          ),
    );
  }
}