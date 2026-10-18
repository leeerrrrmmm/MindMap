import 'package:mind_map/features/auth/data/datasource/auth_datasource/auth_remote_datasource.dart';
import 'package:mind_map/features/auth/data/datasource/user_datasource/user_remote_datasource.dart';
import 'package:mind_map/features/auth/data/model/user_model.dart';
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo/auth_repo.dart';

// data/repo/auth_repo_impl.dart
class AuthRepoImplementation implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  AuthRepoImplementation({
    required AuthRemoteDataSource authRemoteDataSource,
    required UserRemoteDataSource userRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource,
       _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String? goal,
    required int mood,
  }) async {
    final authUser = await _authRemoteDataSource.signUp(
      email: email,
      password: password,
    );

    final user = UserModel(
      uid: authUser.uid,
      customId: authUser.customId,
      email: authUser.email,
      goal: goal,
      mood: mood,
      createdAt: DateTime.now(),
    );

    await _userRemoteDataSource.createUser(user: user);
    return user;
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final authUser = await _authRemoteDataSource.signIn(
      email: email,
      password: password,
    );

    // Профиль уже должен существовать
    return _userRemoteDataSource.getCurrentUser(uid: authUser.uid);
  }

  @override
  Future<UserEntity> signInWithGoogle({String? goal, int? mood}) async {
    final authUser = await _authRemoteDataSource.signInWithGoogle();

    try {
      // Уже есть профиль
      return await _userRemoteDataSource.getCurrentUser(uid: authUser.uid);
    } catch (_) {
      // Первый вход — создаём профиль
      final user = UserModel(
        uid: authUser.uid,
        customId: authUser.customId,
        email: authUser.email,
        firstName: authUser.firstName,
        imageUrl: authUser.imageUrl,
        goal: goal,
        mood: mood ?? 0,
        createdAt: DateTime.now(),
      );

      await _userRemoteDataSource.createUser(user: user);
      return user;
    }
  }

  @override
  Future<void> logout() async {
    await _authRemoteDataSource.logout();
  }
}
