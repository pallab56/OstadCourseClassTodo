import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/models/task_model.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:classtodoapp/widgets/task_card.dart';
import 'package:flutter/material.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  
  List<TaskModel> taskList = [];

  Future<void> getTaskList({required String status}) async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: AppUrl.listTaskByStatusUrl(status),
    );

    List<TaskModel> tempTaskList = [];

    if (response.isScuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tempTaskList.add(TaskModel.fromJson(jsonData));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.responseData['data'])));
    }

    setState(() {
      taskList = List.from(tempTaskList);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTaskList(status: "Completed");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskmodel: taskList[index],
                    cardColor: Colors.red,
                    refreshParent: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}