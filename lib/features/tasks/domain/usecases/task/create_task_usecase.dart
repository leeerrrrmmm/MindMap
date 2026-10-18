import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/domain/repo/task_repository.dart';

class CreateTaskUsecase {
  final TaskRepository _taskRepository;

  CreateTaskUsecase({required TaskRepository taskRepository})
    : _taskRepository = taskRepository;

  Future<void> call(TaskEntity task) async {
    return _taskRepository.createTask(task);
  }
}
