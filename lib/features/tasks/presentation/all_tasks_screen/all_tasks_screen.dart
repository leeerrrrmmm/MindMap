import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_map/features/tasks/cubit/cubit/task_cubit.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/presentation/private/extension/sphere_grouping_extension.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Чистый белый фон, как на макетах
      appBar: AppBar(
        title: const Text(
          'All Tasks',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFAD3743), // Твой фирменный красный
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFAD3743)),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          if (state is! TaskLoaded) {
            return const SizedBox.shrink();
          }

          final tasks = state.tasks;

          if (tasks.isEmpty) {
            return Center(
              child: Text(
                'No tasks yet',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              ),
            );
          }

          // Группируем задачи по сферам
          final Map<Sphere, List<TaskEntity>> groupedTasks = {};
          for (final task in tasks) {
            groupedTasks.putIfAbsent(task.sphere, () => []).add(task);
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              ...groupedTasks.entries.map((entry) {
                final sphere = entry.key;
                final sphereTasks = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок группы (как на макете "Self-improvement")
                      Text(
                        sphere.groupTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Горизонтальный список плашек
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: sphereTasks.map((task) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: _AppStyleTaskChip(task: task),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

// Плашка, которая выглядит как часть дизайн-системы приложения
class _AppStyleTaskChip extends StatelessWidget {
  const _AppStyleTaskChip({required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final color = task.sphere.color;
    final textColor = task.sphere.textColor;

    return Container(
      // Высота 44 (чуть больше 34 для комфортного текста в 2 строки)
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 180),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          12.0,
        ), // Скругление как у кнопок на макете
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              task.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
