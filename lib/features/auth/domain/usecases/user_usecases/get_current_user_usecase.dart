import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/user_repo/user_repo.dart';

class GetCurrentUserUsecase {
  final UserRepo _userRepo;

  const GetCurrentUserUsecase(this._userRepo);

  Future<UserEntity> call({required String uid}) async {
    return _userRepo.getCurrentUser(uid: uid);
  }
}
