import 'package:flutter/material.dart';
import 'package:flutter_ui_class/models/card_data_model.dart';
import 'package:flutter_ui_class/models/task_data_model.dart';
import 'package:flutter_ui_class/providers/task_management_provider.dart';
import 'package:flutter_ui_class/repository/task_manegment_repo.dart';
import 'package:flutter_ui_class/utils/validators.dart';
import 'package:flutter_ui_class/widgets/core_input_field.dart';
import 'package:flutter_ui_class/widgets/password_input_filed.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _assignedToController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late TaskManagementProvider taskProvider;

  @override
  void initState() {
    taskProvider = Provider.of<TaskManagementProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _assignedToController.clear();
    _phoneNumberController.clear();
    _passwordController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CoreInputField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                labelText: "Task Title",
                validator: CustomValidators.validateTaskTitle,
              ),

              const SizedBox(height: 20),
              CoreInputField(
                controller: _assignedToController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                labelText: "Assigned To",
                validator: CustomValidators.validateAssignedTo,
              ),

              const SizedBox(height: 20),
              PasswordInputFiled(controller: _passwordController),

              const SizedBox(height: 40),
              CoreInputField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                labelText: "Task Description",
                validator: CustomValidators.validateDescription,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // final String taskDetails =
              //     "Assigned to: ${_assignedToController.text} \nPhone: ${_phoneNumberController.text} \nDescription: ${_descriptionController.text} \n \n The task Password is ${_passwordController.text}";

              // taskProvider.addTaskExternal(
              //   CardDataModel(
              //     title: _titleController.text,
              //     subtitle: taskDetails,
              //   ),
              // );
              final task = TaskDataModel(
                title: _titleController.text,
                description: _descriptionController.text,
                password: _passwordController.text,
                assignedTo: _assignedToController.text,
              );
              final repo = TaskManegmentRepo();
              repo.addTask(task);

              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Task added successfully!,",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: Text("Add Task"),
        ),
      ),
    );
  }
}
