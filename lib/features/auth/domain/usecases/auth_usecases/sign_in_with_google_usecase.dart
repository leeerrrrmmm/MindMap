import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo/auth_repo.dart';

class SignInWithGoogleUsecase {
  final AuthRepo authRepo;

  const SignInWithGoogleUsecase({required this.authRepo});

  Future<UserEntity> call({String? goal, int? mood}) {
    return authRepo.signInWithGoogle(goal: goal, mood: mood);
  }
}
