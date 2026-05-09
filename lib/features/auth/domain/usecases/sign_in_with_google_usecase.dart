import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo.dart';

class SignInWithGoogleUsecase {
  final AuthRepo authRepo;

  SignInWithGoogleUsecase({required this.authRepo});

  Future<UserEntity> call() {
    return authRepo.signInWithGoogle();
  }
}
