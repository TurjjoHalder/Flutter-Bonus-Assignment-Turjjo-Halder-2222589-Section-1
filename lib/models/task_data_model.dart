// To parse this JSON data, do
//
//     final taskDataModel = taskDataModelFromJson(jsonString);

import 'dart:convert';

List<TaskDataModel> taskDataModelFromJson(String str) => List<TaskDataModel>.from(json.decode(str).map((x) => TaskDataModel.fromJson(x)));

String taskDataModelToJson(List<TaskDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskDataModel {
    String? id;
    String title;
    String description;
    String password;
    String assignedTo;

    TaskDataModel({
        this.id,
        required this.title,
        required this.description,
        required this.password,
        required this.assignedTo,
    });

    factory TaskDataModel.fromJson(Map<String, dynamic> json) => TaskDataModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        password: json["password"],
        assignedTo: json["assigned_to"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "password": password,
        "assigned_to": assignedTo,
    };
}
