import '../../../../core/common/api_result.dart';
import '../entities/login_entity.dart';

abstract class LoginRepo {
  Future<Result<LoginEntity>> login(String email, String password);
}
