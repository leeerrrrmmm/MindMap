import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';

abstract interface class AuthRepo {
  Future<UserEntity> signIn({required String email, required String password});
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String? goal,
    required int mood,
  });
  Future<UserEntity> signInWithGoogle();
  Future<void> logout();
}
