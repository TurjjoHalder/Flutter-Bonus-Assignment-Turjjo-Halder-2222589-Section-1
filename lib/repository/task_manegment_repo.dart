import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ui_class/models/task_data_model.dart';
import 'package:flutter_ui_class/utils/constant.dart';


class TaskManegmentRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<bool>addTask(TaskDataModel taskModel) async{
    try{

      await firestore.collection(AppConstants.taskCollection).add(taskModel.toJson()).then((value){
        firestore.collection(AppConstants.taskCollection).doc(value.id).update({"id": value.id});
      });
      return true;
    }
    catch(e){
      print("Error adding task: $e");
      return false;
    }
  }
}