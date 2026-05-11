import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    super.description,
    required super.sphere,
    required super.deadline,
    required super.isPrivate,
    required super.isCompleted,
    required super.createdAt,
  });

  /// ENTITY -> MODEL
  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      sphere: entity.sphere,
      deadline: entity.deadline,
      isPrivate: entity.isPrivate,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
    );
  }

  /// FIREBASE JSON -> MODEL
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      sphere: Sphere.values.byName(json['sphere'] as String),
      deadline: DateTime.parse(json['deadline'] as String),
      isPrivate: json['isPrivate'] as bool,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// MODEL -> FIREBASE JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sphere': sphere.name,
      'deadline': deadline.toIso8601String(),
      'isPrivate': isPrivate,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
