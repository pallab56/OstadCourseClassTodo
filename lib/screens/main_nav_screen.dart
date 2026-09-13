import 'package:classtodoapp/screens/add_task_screen.dart';
import 'package:classtodoapp/screens/cancel_task_screen.dart';
import 'package:classtodoapp/screens/complete_task_screen.dart';
import 'package:classtodoapp/screens/new_task_screen.dart';
import 'package:classtodoapp/screens/progress_task_screen.dart';
import 'package:classtodoapp/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int selectedIndex = 0;
  List screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompleteTaskScreen(),
    CancelTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: MainAppBar(),

      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.blueGrey.shade100,
        onDestinationSelected: (int index) {
          selectedIndex = index;
          setState(() {});
        },

        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.task), label: 'new'),
          NavigationDestination(
            icon: Icon(Icons.refresh_outlined),
            label: 'progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Complete',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Cancel',
          ),
        ],
      ),
    );
  }
}


