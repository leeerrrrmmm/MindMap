import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/domain/repo/task_repository.dart';

class UpdateTaskUsecase {
  final TaskRepository _taskRepository;

  UpdateTaskUsecase({required TaskRepository taskRepository})
    : _taskRepository = taskRepository;

  Future<void> call(TaskEntity task) async {
    return _taskRepository.updateTask(task);
  }
}
