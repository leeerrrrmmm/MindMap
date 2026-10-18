import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/user_repo/user_repo.dart';

class UpdateUserUsecase {
  final UserRepo _userRepo;

  const UpdateUserUsecase(this._userRepo);

  Future<void> call(UserEntity user) async {
    return _userRepo.updateUser(user);
  }
}
