import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ui_class/data/dummy_data.dart';
// import 'package:flutter_ui_class/models/card_data_model.dart';
import 'package:flutter_ui_class/providers/task_management_provider.dart';
import 'package:flutter_ui_class/screens/add_task_page.dart';
import 'package:flutter_ui_class/utils/constant.dart';
import 'package:flutter_ui_class/widgets/task_card_widget.dart';
import 'package:provider/provider.dart';

class UiPage extends StatefulWidget {
  const UiPage({super.key});

  @override
  State<UiPage> createState() => _UiPageState();
}

class _UiPageState extends State<UiPage> {
  final firestore = FirebaseFirestore.instance;

  // DummyData dummyDataInstance = DummyData();

  @override
  Widget build(BuildContext context) {
    print("Building UI Page...");

    return Scaffold(
      appBar: AppBar(
        title: Text("UI PAGE"),
        backgroundColor: Colors.purpleAccent,
      ),

      // body: Consumer<TaskManagementProvider>(
      //   builder: (context, taskProvider, _) {
      //     return RefreshIndicator(
      //         onRefresh: () async {
      //           setState(() {});
      //         },
      //       child: ListView.builder(
      //         padding: EdgeInsets.all(16),
      //         itemCount: taskProvider.tasks.length,
      //         itemBuilder: (context, index) {
      //           final task = taskProvider.tasks[index];

      //           return TaskCardWidget(
      //             title: task.title,
      //             subtitle: task.subtitle,
      //             icon: task.icon,
      //           );
      //         },
      //       ),
      //     );
      //   }
      // ),
      body: StreamBuilder(
        stream: firestore.collection(AppConstants.taskCollection).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error fetching tasks"));
          }

          final taskDocs = snapshot.data?.docs ?? [];

          if (taskDocs.isEmpty) {
            return Center(child: Text("No tasks available"));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: taskDocs.length,
            itemBuilder: (context, index) {
              final taskData = taskDocs[index];
              return TaskCardWidget(
                title: taskData['title'],
                subtitle: taskData['description'],
                icon: Icons.task, // Placeholder icon
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddTaskPage()));
        },
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
