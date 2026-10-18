import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_map/features/tasks/cubit/map_cubit/map_cubit.dart';
import 'package:mind_map/features/tasks/data/model/map_model/map_model.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';
import 'package:mind_map/features/tasks/presentation/add_task/presentation/add_task_screen.dart';
import 'package:mind_map/features/tasks/presentation/home/widgets/select_sphere_widget.dart';
import 'package:mind_map/navigation/app_routes.dart';
import 'package:mind_map/theme/app_theme.dart';
import 'package:uuid/uuid.dart';

class AddMindMapScreen extends StatefulWidget {
  const AddMindMapScreen({super.key});

  @override
  State<AddMindMapScreen> createState() => _AddMindMapScreenState();
}

class _AddMindMapScreenState extends State<AddMindMapScreen> {
  Sphere? _selectedSphere;
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset('assets/images/red_logo.png'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TOP TEXT
              Text(
                'Add Mind Map',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 28,
                  color: AppTheme.backgroundColor,
                  fontWeight: FontWeight.w700,
                ),
              ),

              ///Title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  TextFormField(
                    controller: _titleController,
                    cursorColor: AppTheme.secondaryColor,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.secondaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.secondaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      hintText: 'Enter mind map title',
                      hintStyle: Theme.of(context).textTheme.bodySmall!
                          .copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.secondaryColor.withValues(
                              alpha: 0.5,
                            ),
                          ),
                    ),
                  ),
                ],
              ),

              //Sphere selector
              SelectSphereWidget(
                selectedSphere: _selectedSphere,
                onSelect: (sphere) => setState(() => _selectedSphere = sphere),
              ),
              const Spacer(),

              //Add Task Button
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: BlocConsumer<MapCubit, MapState>(
                  listener: (context, state) {
                    if (state is MapLoaded) {
                      context.go(AppRoutes.main);
                    }

                    if (state is MapError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is MapLoading;

                    return AddTaskButton(
                      label: isLoading ? 'Adding...' : 'Add Mind Map',
                      onTap: isLoading
                          ? () {}
                          : () {
                              if (_titleController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please enter a title',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.textColor,
                                          ),
                                    ),
                                  ),
                                );
                              } else {
                                final title = _titleController.text.trim();
                                final sphere = _selectedSphere;

                                if (title.isEmpty || sphere == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please select a sphere',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.textColor,
                                            ),
                                      ),
                                    ),
                                  );
                                } else {
                                  context.read<MapCubit>().createMap(
                                    MapModel(
                                      id: Uuid().v4(),
                                      title: _titleController.text,
                                      sphere: _selectedSphere!,
                                    ),
                                  );
                                  _titleController.clear();
                                  Navigator.pop(context);
                                }
                              }
                            },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
