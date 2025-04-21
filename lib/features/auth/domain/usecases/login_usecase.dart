import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../entities/login_entity.dart';
import '../repo/login_repo.dart';

@injectable
class LoginUsecase {
  LoginRepo loginRepo;
  LoginUsecase(this.loginRepo);
  Future<Result<LoginEntity>> login(String email, String password) {
    return loginRepo.login(email, password);
  }
}
