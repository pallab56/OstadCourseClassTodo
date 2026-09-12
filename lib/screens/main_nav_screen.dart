import 'package:classtodoapp/screens/add_task_screen.dart';
import 'package:classtodoapp/screens/cancel_task_screen.dart';
import 'package:classtodoapp/screens/complete_task_screen.dart';
import 'package:classtodoapp/screens/new_task_screen.dart';
import 'package:classtodoapp/screens/progress_task_screen.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
              ),
            ),

            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pallab Chandra das',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'pallab@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),

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
