import 'package:bloc/bloc.dart';
import 'package:mind_map/features/tasks/data/model/task_model.dart';
import 'package:mind_map/features/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:mind_map/features/tasks/domain/usecases/fetch_task_by_id_usecase.dart';
import 'package:mind_map/features/tasks/domain/usecases/fetch_task_usecase.dart';
import 'package:mind_map/features/tasks/domain/usecases/update_task_usecase.dart';

import '../../domain/entity/task_entity.dart';
import '../../domain/usecases/create_task_usecase.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final CreateTaskUsecase createTaskUsecase;
  final FetchTaskUsecase fetchTasksUsecase;
  final FetchTaskByIdUsecase fetchTaskByIdUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;

  TaskCubit({
    required this.createTaskUsecase,
    required this.fetchTasksUsecase,
    required this.fetchTaskByIdUsecase,
    required this.deleteTaskUsecase,
    required this.updateTaskUsecase,
  }) : super(TaskInitial());

  Future<void> addTask(TaskEntity task) async {
    try {
      emit(TaskLoading());

      await createTaskUsecase(task);

      final tasks = await fetchTasksUsecase();

      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<List<TaskModel>> loadTasks() async {
    try {
      emit(TaskLoading());

      final tasks = await fetchTasksUsecase();

      return tasks.map((task) => TaskModel.fromEntity(task)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchTaskById(String taskId) async {
    try {
      emit(TaskLoading());

      final task = await fetchTaskByIdUsecase(taskId);

      emit(TaskLoadedById(task));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      emit(TaskLoading());

      await deleteTaskUsecase(taskId);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      emit(TaskLoading());

      await updateTaskUsecase(task);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
