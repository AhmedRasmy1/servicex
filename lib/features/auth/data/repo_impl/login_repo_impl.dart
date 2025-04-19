import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/auth/data/data_sources/login_data_source.dart';
import 'package:servicex/features/auth/domain/entities/login_entity.dart';
import 'package:servicex/features/auth/domain/repo/login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  LoginDataSource loginDataSource;
  LoginRepoImpl(this.loginDataSource);
  @override
  Future<Result<LoginEntity>> login(String email, String password) {
    return loginDataSource.login(email, password);
  }
}
