import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';

abstract interface class TaskRepository {
  Future<void> createTask(TaskEntity task);

  Future<List<TaskEntity>> fetchTasks();

  Future<TaskEntity> fetchTaskById(String taskId);

  Future<void> deleteTask(String taskId);

  Future<void> updateTask(TaskEntity task);
}
