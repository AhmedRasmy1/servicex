import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/auth/data/data_sources/login_data_source.dart';
import 'package:servicex/features/auth/domain/entities/login_entity.dart';

@Injectable(as: LoginDataSource)
class LoginDataSourceImpl implements LoginDataSource {
  ApiService apiService;
  LoginDataSourceImpl(this.apiService);
  @override
  Future<Result<LoginEntity>> login(String email, String password) {
    return executeApi(() async {
      final response = await apiService.login(email, password);
      final data = response.toLoginEntity();
      return data;
    });
  }
}
