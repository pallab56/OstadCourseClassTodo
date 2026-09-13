import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/models/task_model.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final TaskModel taskmodel;
  final Color cardColor;
  final VoidCallback refreshParent;
  final Color taskCardColor;
  const TaskCard({
    super.key,
    required this.taskmodel,
    required this.cardColor,
    required this.refreshParent,
    required this.taskCardColor,
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

  Future<void> updateTaskStatus(String status) async {
    ApiResponse response = await ApiCaller.getRequest(
      url: AppUrl.updateTaskStaus(widget.taskmodel.sId!, status),
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

  void showChnageStatusDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  updateTaskStatus("New");

                  Navigator.pop(context);
                },
                title: Text("New"),
                trailing: widget.taskmodel.status == "New"
                    ? Icon(Icons.check_circle_outline, color: Colors.green)
                    : null,
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  updateTaskStatus("Cancelled");

                  Navigator.pop(context);
                },
                title: Text("Cancelled"),
                trailing: widget.taskmodel.status == "Cancelled"
                    ? Icon(Icons.check_circle_outline, color: Colors.green)
                    : null,
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  updateTaskStatus("Progress");

                  Navigator.pop(context);
                },
                title: Text("Progress"),
                trailing: widget.taskmodel.status == "Progress"
                    ? Icon(Icons.check_circle_outline, color: Colors.green)
                    : null,
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  updateTaskStatus("Completed");

                  Navigator.pop(context);
                },
                title: Text("Completed"),
                trailing: widget.taskmodel.status == "Completed"
                    ? Icon(Icons.check_circle_outline, color: Colors.green)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: widget.taskCardColor,
      child: ListTile(
        title: Text(
          widget.taskmodel.title.toString(),
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskmodel.description.toString(),style: TextStyle(color: Colors.white,),),
            SizedBox(height: 7),
            Text(widget.taskmodel.createdDate.toString(),style: TextStyle(color: Colors.white,),),
            Row(
              children: [
                Chip(
                  side: BorderSide.none,
                  label: Text(
                    widget.taskmodel.status.toString(),
                    style: TextStyle(color: Colors.white),
                  ),

                  backgroundColor: widget.cardColor,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    showChnageStatusDialog();
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
                  color: const Color.fromARGB(255, 243, 24, 8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
