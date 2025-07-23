import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/core/service/local_storage_service.dart';
import 'package:taba3ni/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:taba3ni/features/auth/presentation/cubit/auth_state.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/usecases/login_teacher_usecase.dart';
import '../../domain/usecases/login_parent_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginTeacherUseCase loginTeacher;
  final LoginParentUseCase loginParent;
  final LogoutUseCase logout;
  final LocalStorageService localStorage;

  AuthCubit({
    required this.loginTeacher,
    required this.loginParent,
    required this.logout,
    required this.localStorage,
  }) : super(AuthInitial());

  Future<void> loginAsTeacher(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginTeacher(email, password);
      await localStorage.saveUser(
        id: user.id,
        type: 'teacher',
        name: user.name,
      );

      emit(AuthSuccess(user));
    } on LoginException {
      emit(const AuthFailure("بيانات الدخول غير صحيحة. حاول مرة أخرى."));
    } on NetworkException {
      emit(const AuthFailure("تحقق من اتصال الإنترنت."));
    } on ServerException {
      emit(const AuthFailure("خطأ في الخادم. حاول لاحقًا."));
    } catch (e) {
      emit(AuthFailure("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }

  Future<void> loginAsParent(String username, String phone) async {
    emit(AuthLoading());
    try {
      final user = await loginParent(username, phone);
      await localStorage.saveUser(id: user.id, type: 'parent', name: user.name);
      emit(AuthSuccess(user));
    } on LoginException {
      emit(const AuthFailure("البيانات التي أدخلتها غير صحيحة."));
    } on NetworkException {
      emit(const AuthFailure("لا يوجد اتصال بالإنترنت."));
    } on ServerException {
      emit(const AuthFailure("حدث خطأ في الخادم."));
    } catch (e) {
      emit(AuthFailure("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }

  Future<void> logoutUser() async {
    await localStorage.clearUser();
    await logout();
    emit(AuthLogOut());
  }
}
