import 'package:flutter/material.dart';
import 'package:flutter_ui_class/repository/task_manegment_repo.dart';

class TaskCardWidget extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  final IconData? icon;

  const TaskCardWidget({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,

    this.icon,
  });

  @override
  Widget build(BuildContext context) {


    return Card(
      elevation: 1,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              "Created at: ${createdAt.toLocal()}",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 4),
            Text(
              "Description: $description",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            
          ],
        ),
        // Text(
        //   "Assigned to: $assignedTo\nDescription: $description",
        //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),

        // ),

        leading: icon != null ? Icon(icon) : Icon(Icons.task),
        trailing: IconButton(
          onPressed: () {
            final repo = TaskManegmentRepo();
            repo.deleteTask(id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Task deleted successfully!",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          },
          icon: Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
        ),
      ),
    );
  }
}
