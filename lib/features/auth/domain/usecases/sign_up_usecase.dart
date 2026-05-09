import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/repo/auth_repo.dart';

class SignUpUsecase {
  final AuthRepo authRepo;

  SignUpUsecase({required this.authRepo});

  Future<UserEntity> call({
    required String email,
    required String password,
    required String confirmPassword,
    required String? goal,
    required int mood,
  }) {
    return authRepo.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      goal: goal,
      mood: mood,
    );
  }
}
