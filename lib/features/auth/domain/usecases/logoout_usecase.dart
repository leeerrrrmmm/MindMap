import 'package:mind_map/features/auth/domain/repo/auth_repo.dart';

class LogoutUsecase {
  final AuthRepo authRepo;

  LogoutUsecase({required this.authRepo});

  Future<void> call() {
    return authRepo.logout();
  }
}
