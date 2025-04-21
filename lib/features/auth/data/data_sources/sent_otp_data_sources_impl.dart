import 'package:injectable/injectable.dart';
import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources_impl/sent_otp_data_sources.dart';

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
