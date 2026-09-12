import 'package:classtodoapp/models/api_response.dart';
import 'package:classtodoapp/screens/main_nav_screen.dart';
import 'package:classtodoapp/service/api_caller.dart';
import 'package:classtodoapp/utils/app_url.dart';
import 'package:classtodoapp/widgets/text_field.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> createTask(String title, String description) async {
    ApiResponse response = await ApiCaller.postRequest(
      url: AppUrl.createTaskUrl,
      body: {"title": title, "description": description, "status": "New"},
    );

    if (response.isScuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.responseData)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * .2),
                  Text(
                    "Add New Task..",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 15),
                  InputField(hintText: 'title', controller: titleController),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: descController,
                    maxLines: 4,
                    decoration: InputDecoration(hintText: 'description'),
                  ),
                  SizedBox(height: 15),
                  FilledButton(
                    onPressed: () {
                      createTask(titleController.text, descController.text);
                    },
                    child: Icon(Icons.navigate_next_outlined, size: 22),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
