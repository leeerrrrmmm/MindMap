import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Sphere { work, health, ideas, personal, finance, learning, other }

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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/red_logo.png'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
            AddTaskButton(
              onTap: () {
                //TODO: implement add task logic
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddTaskButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddTaskButton({required this.onTap, super.key});

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
                'Add new task',
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
