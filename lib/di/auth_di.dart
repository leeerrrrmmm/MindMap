import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mind_map/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:mind_map/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:mind_map/features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'package:mind_map/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:mind_map/features/auth/data/datasource/user_remote_datasource_impl.dart';
import 'package:mind_map/features/auth/data/repo_impl/auth_repo_implementation.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo.dart';
import 'package:mind_map/features/auth/domain/usecases/logoout_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:mind_map/features/tasks/cubit/cubit/task_cubit.dart';
import 'package:mind_map/features/tasks/data/datasource/task_remote_data_source.dart';
import 'package:mind_map/features/tasks/data/datasource/task_remote_data_source_impl.dart';
import 'package:mind_map/features/tasks/data/repo_impl/task_repository_impl.dart';
import 'package:mind_map/features/tasks/domain/repo/task_repository.dart';
import 'package:mind_map/features/tasks/domain/usecases/create_task_usecase.dart';
import 'package:mind_map/features/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:mind_map/features/tasks/domain/usecases/fetch_task_by_id_usecase.dart';
import 'package:mind_map/features/tasks/domain/usecases/fetch_task_usecase.dart';
import 'package:mind_map/features/tasks/domain/usecases/update_task_usecase.dart';

final sl = GetIt.instance;

Future<void> inihDI() async {
  //? ============================== FIREBASE DI ==============================
  //? ============================== FIREBASE DI ==============================

  //! FIREBASE
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);

  //? ============================== AUTH DI ==============================
  //? ============================== AUTH DI ==============================

  //! DATASOURCES
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
      userRemoteDataSource: sl<UserRemoteDataSource>(),
    ),
  );

  //! REPOSITORIES
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplementation(
      authRemoteDataSource: sl<AuthRemoteDataSource>(),
    ),
  );

  //! USE CASES
  sl.registerLazySingleton(() => SignInUsecase(authRepo: sl()));
  sl.registerLazySingleton(() => SignUpUsecase(authRepo: sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUsecase(authRepo: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(authRepo: sl()));

  //! CUBIT
  sl.registerFactory(
    () => AuthCubit(
      signInUsecase: sl(),
      signUpUsecase: sl(),
      signInWithGoogleUsecase: sl(),
      logoutUsecase: sl(),
    ),
  );

  //? ============================== TASK DI ==============================
  //? ============================== TASK DI ==============================

  //! DATASOURCES
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  );

  //! REPOSITORIES
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(taskRemoteDataSource: sl<TaskRemoteDataSource>()),
  );

  //! USE CASES
  sl.registerLazySingleton(() => CreateTaskUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => FetchTaskUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => FetchTaskByIdUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(taskRepository: sl()));

  //! CUBIT
  sl.registerFactory(
    () => TaskCubit(
      createTaskUsecase: sl(),
      fetchTasksUsecase: sl(),
      fetchTaskByIdUsecase: sl(),
      deleteTaskUsecase: sl(),
      updateTaskUsecase: sl(),
    ),
  );
}
