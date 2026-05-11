import 'package:mind_map/features/tasks/data/model/task_model.dart';

abstract interface class TaskRemoteDataSource {
  Future<void> createTask({required TaskModel task});
  Future<List<TaskModel>> fetchTasks();

  Future<TaskModel> fetchTaskById({required String taskId});

  Future<void> deleteTask({required String taskId});

  Future<void> updateTask({required TaskModel task});
}
