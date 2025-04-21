import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/login_data_source.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repo/login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  LoginDataSource loginDataSource;
  LoginRepoImpl(this.loginDataSource);
  @override
  Future<Result<LoginEntity>> login(String email, String password) {
    return loginDataSource.login(email, password);
  }
}
