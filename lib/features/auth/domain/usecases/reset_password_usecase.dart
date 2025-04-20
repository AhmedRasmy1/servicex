import 'package:injectable/injectable.dart';
import 'package:servicex/features/auth/domain/repo/reset_password_repo.dart';

@injectable
class ResetPasswordUsecase {
  ResetPasswordRepo resetPasswordRepo;

  ResetPasswordUsecase(this.resetPasswordRepo);

  Future resetPassword({required String email, required String password}) {
    return resetPasswordRepo.resetPassword(email: email, password: password);
  }
}
