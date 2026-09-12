import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/models/task_model.dart';
import 'package:classtodoapp/models/task_status_count_model.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:classtodoapp/widgets/task_card.dart';
import 'package:classtodoapp/widgets/task_card_count.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskStatusCountModel> listTaskStatusCount = [];
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

  Future<void> getAllTaskCount() async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: AppUrl.taskStatusCountUrl,
    );

    List<TaskStatusCountModel> taskCountByStatus = [];

    if (response.isScuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        taskCountByStatus.add(TaskStatusCountModel.fromJson(jsonData));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.responseData['data'])));
    }

    setState(() {
      listTaskStatusCount = List.from(taskCountByStatus);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTaskCount();
    getTaskList(status: "New");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: listTaskStatusCount.length,
                itemBuilder: (context, index) => TaskCardCount(
                  count: listTaskStatusCount[index].sum!.toInt(),
                  title: listTaskStatusCount[index].sId.toString(),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 7),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskmodel: taskList[index],
                    cardColor: Colors.blue,
                    refreshParent: (){},
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
