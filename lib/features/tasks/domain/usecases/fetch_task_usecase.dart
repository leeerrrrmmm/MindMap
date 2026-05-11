import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/domain/repo/task_repository.dart';

class FetchTaskUsecase {
  final TaskRepository _taskRepository;

  FetchTaskUsecase({required TaskRepository taskRepository})
    : _taskRepository = taskRepository;

  Future<List<TaskEntity>> call() async {
    return _taskRepository.fetchTasks();
  }
}
