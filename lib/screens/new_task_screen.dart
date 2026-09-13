import 'package:classtodoapp/controller/auth_controller.dart';
import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/models/task_model.dart';
import 'package:classtodoapp/models/task_status_count_model.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:classtodoapp/utils/const.dart';
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
      backgroundColor: Colors.black.withAlpha(230),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerSectionUI(),
              GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listTaskStatusCount.length,
                padding: EdgeInsets.all(5),
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5
                ) ,
                itemBuilder: (context, index) {
                  final Color color = APpConst.getAvatarColor(
                    listTaskStatusCount[index].sId.toString(),
                  );
                          
                  return TaskCardCount(
                    color: color,
                    count: listTaskStatusCount[index].sum!.toInt(),
                    title: listTaskStatusCount[index].sId.toString(),
                  );
                }, 
                // separatorBuilder: (context, index) => SizedBox(width: 7),
              ),
              SizedBox(height: 5,),
              Text("  New Task  ",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),
              SizedBox(height: 5,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final Color taskCardColor = APpConst.getAvatarColor(
                    taskList[index].title.toString(),
                  );
                  return TaskCard(
                    taskCardColor: taskCardColor,
                    taskmodel: taskList[index],
                    cardColor: Colors.blue,
                    refreshParent: () {
                      getAllTaskCount();
                      getTaskList(status: "New");
                      setState(() {});
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerSectionUI() {
    String? name = AuthController.userData!.firstName!.toUpperCase();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        RichText(
          textAlign: TextAlign.start,
          
          text: TextSpan(
        
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            
          ),
          children: [
            TextSpan(text: "Hello ",style: TextStyle(fontSize: 18,color: Colors.grey)),
            TextSpan(text:"$name 👏")
          ]
        ),),
        SizedBox(height: 12,),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
        
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            
          ),
          children: [
            TextSpan(text: "Manage Your \n"),
            TextSpan(text:"Daily Task")
          ]
        ),),
        ],
      ),
    );
  }
}
