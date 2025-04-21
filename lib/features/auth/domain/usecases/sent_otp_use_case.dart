import 'package:injectable/injectable.dart';
import '../repo/sent_otp.dart';

@injectable
class SentOtpUseCase {
  SentOtpRepo sentOtpRepo;
  SentOtpUseCase(this.sentOtpRepo);
  Future sentOtp({required String email}) => sentOtpRepo.sentOtp(email: email);
}
