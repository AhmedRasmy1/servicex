import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/auth/domain/entities/login_entity.dart';

abstract class LoginRepo {
  Future<Result<LoginEntity>> login(String email, String password);
}
