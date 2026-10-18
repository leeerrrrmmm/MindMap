import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo/auth_repo.dart';

class SignUpUsecase {
  final AuthRepo authRepo;

  const SignUpUsecase({required this.authRepo});

  Future<UserEntity> call({
    required String email,
    required String password,
    required String? goal,
    required int mood,
  }) {
    return authRepo.signUp(
      email: email,
      password: password,
      goal: goal,
      mood: mood,
    );
  }
}
