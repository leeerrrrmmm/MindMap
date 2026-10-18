import 'package:mind_map/features/tasks/domain/repo/task_repository.dart';

class DeleteTaskUsecase {
  final TaskRepository _taskRepository;

  DeleteTaskUsecase({required TaskRepository taskRepository})
    : _taskRepository = taskRepository;

  Future<void> call(String taskId) async {
    return _taskRepository.deleteTask(taskId);
  }
}
