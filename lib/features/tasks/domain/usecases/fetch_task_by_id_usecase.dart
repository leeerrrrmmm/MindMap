import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/domain/repo/task_repository.dart';

class FetchTaskByIdUsecase {
  final TaskRepository _taskRepository;

  FetchTaskByIdUsecase({required TaskRepository taskRepository})
    : _taskRepository = taskRepository;

  Future<TaskEntity> call(String taskId) async {
    return _taskRepository.fetchTaskById(taskId);
  }
}
