import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/auth/domain/entities/login_entity.dart';
import 'package:servicex/features/auth/domain/repo/login_repo.dart';

@injectable
class LoginUsecase {
  LoginRepo loginRepo;
  LoginUsecase(this.loginRepo);
  Future<Result<LoginEntity>> login(String email, String password) {
    return loginRepo.login(email, password);
  }
}
