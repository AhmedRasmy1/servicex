part of 'sent_otp_cubit.dart';

@immutable
sealed class SentOtpState {}

final class SentOtpInitial extends SentOtpState {}

final class SentOtpLoading extends SentOtpState {}

final class SentOtpSuccess extends SentOtpState {
  final String successMessage;

  SentOtpSuccess(this.successMessage);
}

final class SentOtpError extends SentOtpState {
  final Exception errorMessage;

  SentOtpError(this.errorMessage);
}
