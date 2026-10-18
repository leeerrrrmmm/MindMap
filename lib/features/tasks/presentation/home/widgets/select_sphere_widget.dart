import 'package:flutter/material.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/presentation/add_task/presentation/add_task_screen.dart';

class SelectSphereWidget extends StatelessWidget {
  final Sphere? selectedSphere;
  final Function(Sphere) onSelect;

  const SelectSphereWidget({
    super.key,
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
