import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo.dart';

class SignInUsecase {
  final AuthRepo authRepo;

  SignInUsecase({required this.authRepo});

  Future<UserEntity> call({required String email, required String password}) {
    return authRepo.signIn(email: email, password: password);
  }
}
