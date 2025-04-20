import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/auth/domain/usecases/reset_password_usecase.dart';

part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUsecase _resetPasswordUsecase;
  ResetPasswordCubit(this._resetPasswordUsecase)
    : super(ResetPasswordInitial());
  Future<void> resetPassword({
    required String email,
    required String password,
  }) async {
    emit(ResetPasswordLoading());
    final result = await _resetPasswordUsecase.resetPassword(
      email: email,
      password: password,
    );
    switch (result) {
      case Success<void>():
        emit(ResetPasswordSuccess("Sent successfully"));
        break;
      case Fail<void>():
        emit(ResetPasswordError(result.exception));
        break;
    }
  }
}
