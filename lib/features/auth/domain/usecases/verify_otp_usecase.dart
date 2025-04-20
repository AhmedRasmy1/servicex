import 'package:injectable/injectable.dart';
import 'package:servicex/features/auth/domain/repo/verify_otp_repo.dart';

@injectable
class VerifyOtpUsecase {
  VerifyOtpRepo verifyOtpRepo;
  VerifyOtpUsecase(this.verifyOtpRepo);
  Future verifyOtp({required String otpCode}) =>
      verifyOtpRepo.verifyOtp(otpCode: otpCode);
}
