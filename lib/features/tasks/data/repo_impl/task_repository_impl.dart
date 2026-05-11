import 'package:mind_map/features/tasks/data/datasource/task_remote_data_source.dart';
import 'package:mind_map/features/tasks/data/model/task_model.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/domain/repo/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _taskRemoteDataSource;

  TaskRepositoryImpl({required TaskRemoteDataSource taskRemoteDataSource})
    : _taskRemoteDataSource = taskRemoteDataSource;

  @override
  Future<void> createTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    return _taskRemoteDataSource.createTask(task: model);
  }

  @override
  Future<List<TaskEntity>> fetchTasks() async {
    return await _taskRemoteDataSource.fetchTasks();
  }

  @override
  Future<TaskEntity> fetchTaskById(String taskId) async {
    return await _taskRemoteDataSource.fetchTaskById(taskId: taskId);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    return await _taskRemoteDataSource.deleteTask(taskId: taskId);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    return await _taskRemoteDataSource.updateTask(task: model);
  }
}
