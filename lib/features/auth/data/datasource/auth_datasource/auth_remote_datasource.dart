import 'package:mind_map/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUp({required String email, required String password});

  Future<UserModel> signIn({required String email, required String password});

  Future<UserModel> signInWithGoogle();

  Future<void> logout();
}
