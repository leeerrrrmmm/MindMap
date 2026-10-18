import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/usecases/auth_usecases/logoout_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/auth_usecases/sign_in_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/auth_usecases/sign_in_with_google_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/auth_usecases/sign_up_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUsecase signUpUsecase;
  final SignInUsecase signInUsecase;
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  final LogoutUsecase logoutUsecase;

  AuthCubit({
    required this.signUpUsecase,
    required this.signInUsecase,
    required this.signInWithGoogleUsecase,
    required this.logoutUsecase,
  }) : super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String? goal,
    required int mood,
  }) async {
    emit(AuthLoading());
    try {
      final user = await signUpUsecase(
        email: email,
        password: password,
        goal: goal,
        mood: mood,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await signInUsecase(email: email, password: password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithGoogle({String? goal, int? mood}) async {
    emit(AuthLoading());
    try {
      final user = await signInWithGoogleUsecase(goal: goal, mood: mood);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    await logoutUsecase();
    emit(AuthInitial());
  }
}
