import 'package:injectable/injectable.dart';
import 'package:servicex/features/auth/data/data_sources/verify_otp_data_source.dart';
import 'package:servicex/features/auth/domain/repo/verify_otp_repo.dart';

@Injectable(as: VerifyOtpRepo)
class VerifyOtpRepoImpl implements VerifyOtpRepo {
  VerifyOtpDataSource verifyOtpDataSource;
  VerifyOtpRepoImpl(this.verifyOtpDataSource);
  @override
  Future verifyOtp({required String otpCode}) {
    return verifyOtpDataSource.verifyOtp(otpCode: otpCode);
  }
}
