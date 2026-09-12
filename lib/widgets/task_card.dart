import 'package:classtodoapp/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskmodel;
  final Color cardColor;
  final VoidCallback refreshParent;
  const TaskCard({
    super.key,
    required this.taskmodel,
    required this.cardColor,
    required this.refreshParent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.blueGrey[100],
      child: ListTile(
        title: Text(
          taskmodel.title.toString(),
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskmodel.description.toString()),
            SizedBox(height: 7),
            Text(taskmodel.createdDate.toString()),
            Row(
              children: [
                Chip(
                  label: Text(
                    taskmodel.status.toString(),
                    style: TextStyle(color: Colors.white),
                  ),

                  backgroundColor: cardColor,
                ),
                Spacer(),
                Icon(
                  Icons.edit_note,
                  color: const Color.fromARGB(255, 233, 175, 88),
                ),
                SizedBox(width: 5),
                Icon(Icons.delete, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
