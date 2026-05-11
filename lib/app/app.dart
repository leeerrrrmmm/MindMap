import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_map/di/auth_di.dart';
import 'package:mind_map/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:mind_map/features/tasks/cubit/cubit/task_cubit.dart';
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
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: AppThemeData.light,
      ),
    );
  }
}
