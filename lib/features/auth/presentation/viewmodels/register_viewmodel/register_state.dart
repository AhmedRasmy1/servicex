part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String message;

  RegisterSuccess({required this.message});
}

final class RegisterError extends RegisterState {
  final Exception errorMessage;

  RegisterError({required this.errorMessage});
}
