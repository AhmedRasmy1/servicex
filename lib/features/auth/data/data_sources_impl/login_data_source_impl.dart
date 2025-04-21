import 'package:injectable/injectable.dart';
import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/login_data_source.dart';
import '../../domain/entities/login_entity.dart';

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
