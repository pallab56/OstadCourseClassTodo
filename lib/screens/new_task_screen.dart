import 'package:classtodoapp/models/task_status_count_model.dart';
import 'package:classtodoapp/widgets/task_card.dart';
import 'package:classtodoapp/widgets/task_card_count.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskStatusCountModel> taskStatusCount = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TaskCardCount(count: 254, title: 'New '),

            TaskCard(),
          ],
        ),
      ),
    );
  }
}
