import '../../../../core/common/api_result.dart';
import '../../domain/entities/login_entity.dart';

abstract class LoginDataSource {
  Future<Result<LoginEntity>> login(String email, String password);
}
