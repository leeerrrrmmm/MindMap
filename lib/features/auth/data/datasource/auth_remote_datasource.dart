import 'package:mind_map/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String? goal,
    required int mood,
  });

  Future<UserModel> signInWithGoogle();

  Future<void> logout();
}
