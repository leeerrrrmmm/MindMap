part of 'task_cubit.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;

  TaskLoaded(this.tasks);
}

class TaskLoadedById extends TaskState {
  final TaskEntity task;

  TaskLoadedById(this.task);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}
