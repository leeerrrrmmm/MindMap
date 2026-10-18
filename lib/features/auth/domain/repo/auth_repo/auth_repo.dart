// domain/repo/auth_repo.dart
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';

abstract interface class AuthRepo {
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String? goal,
    required int mood,
  });

  Future<UserEntity> signIn({required String email, required String password});

  Future<UserEntity> signInWithGoogle({String? goal, int? mood});

  Future<void> logout();
}
