import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/models/task_model.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
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
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Future<void> deleteTask() async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: AppUrl.deleteTaskUrl(widget.taskmodel.sId!),
    );
    if (response.isScuccess) {
      widget.refreshParent();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Task Deleted")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong!!")));
    }
  }

  Future<void> updateTaskStatus() async {
    ApiResponse response = await ApiCaller.getRequest(
      url: AppUrl.updateTaskStaus(
        widget.taskmodel.sId!,
        widget.taskmodel.status!,
      ),
    );
    setState(() {});
    if (response.isScuccess) {
      widget.refreshParent();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Task Updated")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong!!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.blueGrey[100],
      child: ListTile(
        title: Text(
          widget.taskmodel.title.toString(),
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskmodel.description.toString()),
            SizedBox(height: 7),
            Text(widget.taskmodel.createdDate.toString()),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskmodel.status.toString(),
                    style: TextStyle(color: Colors.white),
                  ),

                  backgroundColor: widget.cardColor,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    updateTaskStatus(
                       
                    );
                  },
                  icon: Icon(Icons.edit_note),
                  color: const Color.fromARGB(255, 233, 175, 88),
                ),
                SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    deleteTask();
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
