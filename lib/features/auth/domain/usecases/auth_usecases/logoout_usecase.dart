import 'package:mind_map/features/auth/domain/repo/auth_repo/auth_repo.dart';

class LogoutUsecase {
  final AuthRepo authRepo;

  const LogoutUsecase({required this.authRepo});

  Future<void> call() => authRepo.logout();
}
