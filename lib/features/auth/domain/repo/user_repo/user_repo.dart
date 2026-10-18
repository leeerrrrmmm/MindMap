// domain/repo/user_repo.dart
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';

abstract interface class UserRepo {
  Future<UserEntity> getCurrentUser({required String uid});
  Future<void> updateUser(UserEntity user);
  Future<void> deleteUser({required String uid});
}
