import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_map/features/tasks/cubit/task_cubit/task_cubit.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/core/extension/sphere_grouping_extension.dart';
import 'package:mind_map/features/tasks/presentation/private/widgets/empty_goals_state_widget.dart';
import 'package:mind_map/navigation/app_routes.dart';

const List<String> _privateGroups = [
  'Personal goals and experiences',
  'Work & Finance',
];

class PrivateTaskScreen extends StatelessWidget {
  const PrivateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/red_logo.png',
          height: 32,
          color: const Color(0xFFAD3743),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        backgroundColor: Theme.of(context).primaryColor,
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

          final privateTasks = state.tasks.where((t) => t.isPrivate).toList();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Private Tasks',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFAD3743),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ..._privateGroups.map((groupTitle) {
                    final tasksInGroup = privateTasks.where((task) {
                      return task.sphere.belongsTo(groupTitle);
                    }).toList();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: _CategorySection(
                        title: groupTitle,
                        tasks: tasksInGroup,
                        onAdd: () => context.push(AppRoutes.addTask),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.title,
    required this.tasks,
    required this.onAdd,
  });

  final String title;
  final List<TaskEntity> tasks;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),

        if (tasks.isEmpty)
          EmptyGoalsStateWidget(onTap: onAdd)
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tasks.map((task) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _PrivateTaskChip(task: task),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class _PrivateTaskChip extends StatelessWidget {
  const _PrivateTaskChip({required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final color = task.sphere.color;
    final textColor = task.sphere.textColor;

    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            task.sphere.icon,
            size: 16,
            color: textColor.withValues(alpha: 0.8),
          ),
          const SizedBox(width: 6),
          Text(
            task.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
