import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/features/auth/data/data_sources_impl/sent_otp_data_sources.dart';

@Injectable(as: SentOtpDataSource)
class SentOtpDataSourcesImpl implements SentOtpDataSource {
  ApiService apiService;
  SentOtpDataSourcesImpl(this.apiService);
  @override
  Future sentOtp({required String email}) {
    return executeApi(() async {
      final response = await apiService.sentOtp(email);
      return response;
    });
  }
}
