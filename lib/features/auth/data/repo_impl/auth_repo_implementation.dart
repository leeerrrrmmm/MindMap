import 'package:mind_map/features/auth/data/datasource/auth_repote_datasource.dart';
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImplementation({required AuthRemoteDataSource authRemoteDataSource})
    : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    return _authRemoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String? goal,
    required int mood,
  }) async {
    return _authRemoteDataSource.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      goal: goal,
      mood: mood,
    );
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    return _authRemoteDataSource.signInWithGoogle();
  }

  @override
  Future<void> logout() async {
    return _authRemoteDataSource.logout();
  }
}
