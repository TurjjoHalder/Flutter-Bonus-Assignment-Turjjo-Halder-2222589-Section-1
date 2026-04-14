import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<TaskDataModel> taskDataModelFromJson(String str) => 
    List<TaskDataModel>.from(json.decode(str).map((x) => TaskDataModel.fromJson(x)));

String taskDataModelToJson(List<TaskDataModel> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskDataModel {
  String? id;
  String title;
  String description;
  DateTime createdAt; // Changed from String to DateTime

  TaskDataModel({
     this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  // Updated factory to handle Firestore Timestamp
  factory TaskDataModel.fromJson(Map<String, dynamic> json) {
    return TaskDataModel(
      id: json["id"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      // If data comes from Firestore, it's a Timestamp. If from JSON, it's a String.
      createdAt: json["created_at"] is Timestamp 
          ? (json["created_at"] as Timestamp).toDate() 
          : DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    // Convert DateTime back to Timestamp for Firestore storage
    "created_at": Timestamp.fromDate(createdAt),
  };
}