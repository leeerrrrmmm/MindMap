import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_map/features/auth/cubit/user_cubit/user_cubit.dart';
import 'package:mind_map/features/tasks/cubit/task_cubit/task_cubit.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/presentation/add_task/presentation/add_task_screen.dart';
import 'package:mind_map/features/tasks/presentation/home/widgets/down_block_container_widget.dart';
import 'package:mind_map/features/tasks/presentation/home/widgets/mind_map_bloc.dart';
import 'package:mind_map/features/tasks/presentation/home/widgets/quick_thougt_container_widget.dart';
import 'package:mind_map/features/tasks/presentation/home/widgets/top_right_btn_widget.dart';
import 'package:mind_map/navigation/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          return BlocBuilder<TaskCubit, TaskState>(
            builder: (context, taskState) {
              final isLoading =
                  userState is UserLoading ||
                  userState is UserInitial ||
                  taskState is TaskLoading ||
                  taskState is TaskInitial;

              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (userState is UserFailure) {
                return Center(child: Text(userState.message));
              }

              if (taskState is TaskError) {
                return Center(child: Text(taskState.message));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const _TopWidget(),
                    const Padding(
                      padding: EdgeInsets.only(top: 18),
                      child: _MainInfoWidget(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _MainInfoWidget extends StatelessWidget {
  const _MainInfoWidget();

  List<T> topList<T>(List<T> items) {
    return [
      for (int i = 0; i < items.length; i++)
        if (i % 2 == 0) items[i],
    ];
  }

  List<T> bottomList<T>(List<T> items) {
    return [
      for (int i = 0; i < items.length; i++)
        if (i % 2 == 1) items[i],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Quick thought',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: QuickThoughtContainerWidget(),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Your tasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocConsumer<TaskCubit, TaskState>(
              listener: (context, state) {
                if (state is TaskLoaded) {
                  log('Task Loaded');
                }
                if (state is TaskError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is TaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TaskLoaded) {
                  final tasks = state.tasks;
                  if (tasks.isEmpty) {
                    return Center(
                      child: Text(
                        'No tasks found',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  }

                  final topTasks = topList(tasks);
                  final bottomTasks = bottomList(tasks);

                  return Column(
                    children: [
                      tasks.length <= 3
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: SizedBox(
                                height: 68,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 10),
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) {
                                    return _TaskCard(task: tasks[index]);
                                  },
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: _TwoTasksListViewWidget(
                                topTasks: topTasks,
                                bottomTasks: bottomTasks,
                              ),
                            ),
                    ],
                  );
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Text(
                      'No tasks found',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Block for you',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DownBlockContainerWidget(
                    image: 'assets/images/private_bloc.png',
                    color: Color(0xFfAD3743),
                    title: 'Private Tasks',
                    icon: Icons.lock,
                    onTap: () {
                      context.push(AppRoutes.private);
                    },
                  ),
                  DownBlockContainerWidget(
                    image: 'assets/images/idea_bloc.png',
                    color: Color(0xFF7CAD37),
                    title: 'Ideas for tasks',
                    icon: Icons.lightbulb,
                    onTap: () {
                      context.push(AppRoutes.ideas);
                    },
                  ),
                ],
              ),
              MindMapBloc(
                title: 'Mind Map',
                onTap: () {
                  context.push(AppRoutes.addMindMap);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }
}

class _TwoTasksListViewWidget extends StatelessWidget {
  const _TwoTasksListViewWidget({
    required this.topTasks,
    required this.bottomTasks,
  });

  final List<TaskEntity> topTasks;
  final List<TaskEntity> bottomTasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 68,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10),
            itemCount: topTasks.length,
            itemBuilder: (context, index) {
              return _TaskCard(task: topTasks[index]);
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 68,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10),
            itemCount: bottomTasks.length,
            itemBuilder: (context, index) {
              return _TaskCard(task: bottomTasks[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskEntity task;

  const _TaskCard({required this.task});

  Color getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.4 ? Colors.black : Colors.white;
  }

  String nameToUpperCase(String name) {
    List<String> letters = name.split('');
    return letters.first.toUpperCase() + letters.skip(1).join('').toLowerCase();
  }

  SphereColor get sphereColor => SphereColor.values.byName(task.sphere.name);

  @override
  Widget build(BuildContext context) {
    final color = sphereColor.color;
    final textColor = getContrastColor(color);

    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 175,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameToUpperCase(sphereColor.name),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            task.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopWidget extends StatelessWidget {
  const _TopWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          final user = state.user;
          final fName = user.firstName;
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: 154,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: -50,
                    child: CircleAvatar(
                      radius: 140,
                      backgroundColor: Color(0xFFAD3743).withValues(alpha: 0.7),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(26.0, 40.0, 20.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Image.asset('assets/images/logo.png', scale: 3),
                                Text(
                                  'MindMap24',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(text: 'Hi, '),
                                    TextSpan(
                                      text: '$fName',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\nWelcome to your mind map!',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 20,
                          children: [
                            TopRightBtnWidget(
                              onTap: () {},
                              icon: Icons.notifications_outlined,
                            ),
                            TopRightBtnWidget(
                              onTap: () {},
                              icon: Icons.edit_outlined,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is UserFailure) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
