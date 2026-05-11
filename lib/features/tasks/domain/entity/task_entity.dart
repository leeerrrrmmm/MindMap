enum Sphere { work, health, ideas, personal, finance, learning, other }

class TaskEntity {
  final String id;
  final String title;
  final String? description;
  final Sphere sphere;
  final DateTime deadline;
  final bool isPrivate;
  final bool isCompleted;
  final DateTime createdAt;

  TaskEntity({
    required this.id,
    required this.title,
    required this.sphere,
    required this.deadline,
    required this.isPrivate,
    required this.isCompleted,
    required this.createdAt,
    this.description,
  });
}
