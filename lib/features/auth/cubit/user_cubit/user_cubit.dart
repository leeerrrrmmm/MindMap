import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';
import 'package:mind_map/features/auth/domain/usecases/user_usecases/delete_user_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/user_usecases/get_current_user_usecase.dart';
import 'package:mind_map/features/auth/domain/usecases/user_usecases/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final UpdateUserUsecase updateUserUsecase;
  final DeleteUserUsecase deleteUserUsecase;

  UserCubit({
    required this.getCurrentUserUsecase,
    required this.updateUserUsecase,
    required this.deleteUserUsecase,
  }) : super(const UserInitial());

  Future<void> loadUser({required String uid}) async {
    emit(const UserLoading());
    try {
      final user = await getCurrentUserUsecase(uid: uid);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> updateUser(UserEntity user) async {
    emit(const UserLoading());
    try {
      await updateUserUsecase(user);
      emit(UserUpdated(user));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> deleteUser({required String uid}) async {
    emit(const UserLoading());
    try {
      await deleteUserUsecase(uid: uid);
      emit(const UserDeleted());
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
