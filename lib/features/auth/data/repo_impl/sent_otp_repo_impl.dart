import 'package:injectable/injectable.dart';
import 'package:servicex/features/auth/data/data_sources_impl/sent_otp_data_sources.dart';
import 'package:servicex/features/auth/domain/repo/sent_otp.dart';

@Injectable(as: SentOtpRepo)
class SentOtpRepoImpl implements SentOtpRepo {
  SentOtpDataSource sentOtpDataSource;
  SentOtpRepoImpl(this.sentOtpDataSource);
  @override
  Future sentOtp({required String email}) {
    return sentOtpDataSource.sentOtp(email: email);
  }
}
