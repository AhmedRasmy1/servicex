import 'package:injectable/injectable.dart';
import 'package:servicex/features/auth/data/data_sources/reset_password_data_sources.dart';
import 'package:servicex/features/auth/domain/repo/reset_password_repo.dart';

@Injectable(as: ResetPasswordRepo)
class ResetPasswordRepoImpl implements ResetPasswordRepo {
  ResetPasswordDataSource resetPasswordDataSource;
  ResetPasswordRepoImpl(this.resetPasswordDataSource);
  @override
  Future resetPassword({required String email, required String password}) {
    return resetPasswordDataSource.resetPassword(
      email: email,
      password: password,
    );
  }
}
