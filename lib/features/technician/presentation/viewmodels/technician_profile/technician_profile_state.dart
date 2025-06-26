part of 'technician_profile_cubit.dart';

@immutable
sealed class TechnicianProfileState {}

final class TechnicianProfileInitial extends TechnicianProfileState {}

final class TechnicianProfileLoading extends TechnicianProfileState {}

final class TechnicianProfileSuccess extends TechnicianProfileState {
  final TechnicianProfileEntity technicianProfile;

  TechnicianProfileSuccess(this.technicianProfile);
}

final class TechnicianProfileError extends TechnicianProfileState {
  final String message;

  TechnicianProfileError(this.message);
}
