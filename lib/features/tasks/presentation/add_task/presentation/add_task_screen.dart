import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mind_map/features/tasks/cubit/cubit/task_cubit.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/navigation/app_router.dart';
import 'package:uuid/uuid.dart';

enum SphereColor {
  work(Color(0xFFD96A78)),
  health(Color(0xFFF2C6CB)),
  ideas(Color(0xFFE9A14E)),
  personal(Color(0xFF66C6B9)),
  finance(Color(0xFFF3E2C7)),
  learning(Color(0xFFA2B3D9)),
  other(Color(0xFFD96A78));

  final Color color;
  const SphereColor(this.color);
}

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();

  DateTime? _selectedDate = DateTime.now();
  Sphere? _selectedSphere;
  bool _isPrivate = false;

  Future<void> _selectDeadLine() async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              todayBackgroundColor: WidgetStateProperty.all(
                Theme.of(context).scaffoldBackgroundColor,
              ),
              todayForegroundColor: WidgetStateProperty.all(Colors.white),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2036),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/red_logo.png'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                const SizedBox(),
                Text(
                  'Create new Task:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),

                _WriteYourNameTaskWidget(taskController: _taskController),

                _SelectASphereWidget(
                  selectedSphere: _selectedSphere,
                  onSelect: (sphere) {
                    setState(() => _selectedSphere = sphere);
                  },
                ),

                _SelectDeadLine(
                  selectedDate: _selectedDate,
                  onTap: _selectDeadLine,
                ),

                _IsPrivateTaskWidget(
                  isPrivate: _isPrivate,
                  onChanged: (value) {
                    setState(() => _isPrivate = value ?? false);
                  },
                ),
                BlocConsumer<TaskCubit, TaskState>(
                  listener: (context, state) {
                    if (state is TaskLoaded) {
                      context.go(AppRoutes.main);
                    }

                    if (state is TaskError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },

                  builder: (context, state) {
                    final isLoading = state is TaskLoading;

                    return AddTaskButton(
                      onTap: isLoading
                          ? () {}
                          : () {
                              final taskTitle = _taskController.text.trim();
                              final taskSphere = _selectedSphere;
                              final taskDeadline = _selectedDate;
                              final taskIsPrivate = _isPrivate;

                              if (taskTitle.isEmpty || taskDeadline == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please fill all fields'),
                                  ),
                                );
                                return;
                              }

                              context.read<TaskCubit>().addTask(
                                TaskEntity(
                                  id: const Uuid().v4(),
                                  title: taskTitle,
                                  sphere: taskSphere ?? Sphere.other,
                                  deadline: taskDeadline,
                                  isPrivate: taskIsPrivate,
                                  isCompleted: false,
                                  createdAt: DateTime.now(),
                                ),
                              );

                              _taskController.clear();
                              _selectedDate = null;
                              _selectedSphere = null;
                              _isPrivate = false;
                              setState(() {});
                            },
                      label: isLoading ? 'Loading...' : 'Add new task',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}

class AddTaskButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const AddTaskButton({required this.onTap, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Icon(
                Icons.exit_to_app_outlined,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IsPrivateTaskWidget extends StatelessWidget {
  final bool isPrivate;
  final void Function(bool?)? onChanged;
  const _IsPrivateTaskWidget({
    required this.isPrivate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.4,
          child: Checkbox(
            value: isPrivate,
            onChanged: onChanged,

            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Color(0xFFD9D9D9);
              }
              return Color(0xFFD9D9D9);
            }),

            checkColor: Colors.black,

            side: BorderSide(color: Colors.grey, width: 2),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        Text(
          'Private',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

class _SelectDeadLine extends StatelessWidget {
  final VoidCallback onTap;
  final DateTime? selectedDate;

  const _SelectDeadLine({required this.onTap, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final date = selectedDate ?? DateTime.now();
    final formatted = DateFormat('dd MMM yyyy').format(date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a dead-line',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.calendar_month_outlined),
                const SizedBox(width: 10),
                Text(
                  formatted,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectASphereWidget extends StatelessWidget {
  final Sphere? selectedSphere;
  final Function(Sphere) onSelect;

  const _SelectASphereWidget({
    required this.selectedSphere,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a sphere',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(Sphere.values.length, (index) {
            final sphere = Sphere.values[index];
            final isSelected = sphere == selectedSphere;

            return GestureDetector(
              onTap: () => onSelect(sphere),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: SphereColor.values[index].color,
                  borderRadius: BorderRadius.circular(15),
                  border: isSelected
                      ? Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        )
                      : null,
                ),
                child: Text(
                  sphere.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _WriteYourNameTaskWidget extends StatelessWidget {
  final TextEditingController taskController;

  const _WriteYourNameTaskWidget({required this.taskController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: taskController,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'Write your task here',
            filled: true,
            fillColor: Theme.of(context).primaryColor.withValues(alpha: 0.5),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
