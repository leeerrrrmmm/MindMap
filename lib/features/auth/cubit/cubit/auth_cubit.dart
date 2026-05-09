import 'package:bloc/bloc.dart';
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/usecases/logoout_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final LogoutUsecase _logoutUsecase;

  AuthCubit({
    required SignInUsecase signInUsecase,
    required SignUpUsecase signUpUsecase,
    required SignInWithGoogleUsecase signInWithGoogleUsecase,
    required LogoutUsecase logoutUsecase,
  }) : _signInUsecase = signInUsecase,
       _signUpUsecase = signUpUsecase,
       _signInWithGoogleUsecase = signInWithGoogleUsecase,
       _logoutUsecase = logoutUsecase,
       super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String? goal,
    required int mood,
  }) async {
    try {
      emit(AuthLoading());
      final UserEntity user = await _signUpUsecase.call(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        goal: goal,
        mood: mood,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      throw Exception(e);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      final UserEntity user = await _signInUsecase.call(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      throw Exception(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());

      final user = await _signInWithGoogleUsecase.call();

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      await _logoutUsecase.call();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
      throw Exception(e);
    }
  }
}
