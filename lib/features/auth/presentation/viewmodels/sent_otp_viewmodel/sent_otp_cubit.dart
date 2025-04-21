import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/common/api_result.dart';
import '../../../domain/usecases/sent_otp_use_case.dart';

part 'sent_otp_state.dart';

@injectable
class SentOtpCubit extends Cubit<SentOtpState> {
  final SentOtpUseCase _sentOtpUseCase;
  SentOtpCubit(this._sentOtpUseCase) : super(SentOtpInitial());

  Future<void> sentOtp({required String email}) async {
    emit(SentOtpLoading());
    final result = await _sentOtpUseCase.sentOtp(email: email);
    switch (result) {
      case Success<void>():
        emit(SentOtpSuccess("Sent successfully"));
        break;
      case Fail<void>():
        emit(SentOtpError(result.exception));
        break;
    }
  }
}
