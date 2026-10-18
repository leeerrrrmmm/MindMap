import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_map/di/di.dart';
import 'package:mind_map/features/auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:mind_map/features/auth/cubit/user_cubit/user_cubit.dart';
import 'package:mind_map/features/tasks/cubit/map_cubit/map_cubit.dart';
import 'package:mind_map/features/tasks/cubit/task_cubit/task_cubit.dart';
import 'package:mind_map/navigation/app_router.dart';
import 'package:mind_map/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<TaskCubit>()),
        BlocProvider(create: (_) => sl<UserCubit>()),
        BlocProvider(create: (_) => sl<MapCubit>()),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: AppThemeData.light,
      ),
    );
  }
}
