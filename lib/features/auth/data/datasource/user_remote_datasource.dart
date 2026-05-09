import 'package:mind_map/features/auth/data/model/user_model.dart';

abstract interface class UserRemoteDataSource {
  Future<void> createUser({required UserModel user});

  Future<UserModel> getCurrentUser({required String uid});

  Future<void> updateUser({required UserModel user});

  Future<void> deleteUser({required String uid});
}
