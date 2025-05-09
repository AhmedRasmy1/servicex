import 'package:injectable/injectable.dart';
import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources/verify_otp_data_source.dart';

@Injectable(as: VerifyOtpDataSource)
class VerifyOtpDataSourcesImpl implements VerifyOtpDataSource {
  ApiService apiService;
  VerifyOtpDataSourcesImpl(this.apiService);
  @override
  Future verifyOtp({required String otpCode}) {
    return executeApi(() async {
      final response = await apiService.verifyOtp(otpCode);
      return response;
    });
  }
}
