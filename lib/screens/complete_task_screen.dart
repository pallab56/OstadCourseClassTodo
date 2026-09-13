import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/models/task_model.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:classtodoapp/utils/const.dart';
import 'package:classtodoapp/widgets/task_card.dart';
import 'package:flutter/material.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  
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
                  final Color taskCardColor = APpConst.getAvatarColor(
                    taskList[index].title.toString(),
                  );
                  return TaskCard(
                    taskCardColor: taskCardColor,
                    taskmodel: taskList[index],
                    cardColor: Colors.green,
                    refreshParent: () {
                      
                      getTaskList(status: "Completed");
                      setState(() {
                        
                      });
                    },
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