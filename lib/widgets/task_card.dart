import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            color: Colors.blueGrey[100],
            child: ListTile(
                        
              title: Text('Task Title',
              style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),
              ),
            
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Des:'),
                  SizedBox(height: 7,),
                  Text(DateTime.now().toString()),
                  Row(
                    children: [
                      Chip(label: Text('New',style: TextStyle(color: Colors.white),),
            
                      backgroundColor: Colors.blue,
                      ),
                      Spacer(),
                      Icon(Icons.edit_note,color: const Color.fromARGB(255, 233, 175, 88),),
                      SizedBox(width: 5,),
                      Icon(Icons.delete,color: Colors.red,)
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
