import 'package:injectable/injectable.dart';
import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources/reset_password_data_sources.dart';

@Injectable(as: ResetPasswordDataSource)
class ResetPasswordDataSourcesImpl implements ResetPasswordDataSource {
  ApiService apiService;
  ResetPasswordDataSourcesImpl(this.apiService);
  @override
  Future resetPassword({required String email, required String password}) {
    return executeApi(() async {
      final response = await apiService.resetPassword(email, password);
      return response;
    });
  }
}
