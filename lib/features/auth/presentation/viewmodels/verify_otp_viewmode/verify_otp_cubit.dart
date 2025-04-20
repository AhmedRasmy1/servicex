import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/auth/domain/usecases/verify_otp_usecase.dart';

part 'verify_otp_state.dart';

@injectable
class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpUsecase _verifyOtpUsecase;
  VerifyOtpCubit(this._verifyOtpUsecase) : super(VerifyOtpInitial());
  Future<void> verifyOtp({required String otpCode}) async {
    emit(VerifyOtpLoading());
    final result = await _verifyOtpUsecase.verifyOtp(otpCode: otpCode);
    switch (result) {
      case Success<void>():
        emit(VerifyOtpSuccess("Sent successfully"));
        break;
      case Fail<void>():
        emit(VerifyOtpError(result.exception));
        break;
    }
  }
}
