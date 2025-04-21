import 'package:injectable/injectable.dart';
import '../data_sources/verify_otp_data_source.dart';
import '../../domain/repo/verify_otp_repo.dart';

@Injectable(as: VerifyOtpRepo)
class VerifyOtpRepoImpl implements VerifyOtpRepo {
  VerifyOtpDataSource verifyOtpDataSource;
  VerifyOtpRepoImpl(this.verifyOtpDataSource);
  @override
  Future verifyOtp({required String otpCode}) {
    return verifyOtpDataSource.verifyOtp(otpCode: otpCode);
  }
}
