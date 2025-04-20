import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/features/auth/data/data_sources/reset_password_data_sources.dart';

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
