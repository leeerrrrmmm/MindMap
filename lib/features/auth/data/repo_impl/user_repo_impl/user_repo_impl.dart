import 'package:mind_map/features/auth/data/datasource/user_datasource/user_remote_datasource.dart';
import 'package:mind_map/features/auth/data/model/user_model.dart';
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/user_repo/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource _userRemoteDataSource;

  const UserRepoImpl(this._userRemoteDataSource);

  @override
  Future<UserEntity> getCurrentUser({required String uid}) async {
    return _userRemoteDataSource.getCurrentUser(uid: uid);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    return _userRemoteDataSource.updateUser(user: UserModel.fromEntity(user));
  }

  @override
  Future<void> deleteUser({required String uid}) async {
    return _userRemoteDataSource.deleteUser(uid: uid);
  }
}
