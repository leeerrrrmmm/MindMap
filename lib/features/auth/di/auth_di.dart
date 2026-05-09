import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mind_map/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:mind_map/features/auth/data/datasource/auth_repote_datasource.dart';
import 'package:mind_map/features/auth/data/datasource/auth_repote_datasource_impl.dart';
import 'package:mind_map/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:mind_map/features/auth/data/datasource/user_remote_datasource_impl.dart';
import 'package:mind_map/features/auth/data/repo_impl/auth_repo_implementation.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo.dart';
import 'package:mind_map/features/auth/domain/usecases/logoout_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_up_usecase.dart';

final sl = GetIt.instance;

Future<void> initAuthDI() async {
  //! FIREBASE
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);

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
    () => AuthRepoImplementation(authRemoteDataSource: sl<AuthRemoteDataSource>()),
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
}
