import 'package:mind_map/features/auth/domain/repo/user_repo/user_repo.dart';

class DeleteUserUsecase {
  final UserRepo _userRepo;

  const DeleteUserUsecase(this._userRepo);

  Future<void> call({required String uid}) async {
    return _userRepo.deleteUser(uid: uid);
  }
}
