part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileSuccess extends UserProfileState {
  final UserProfileEntity userProfileEntity;

  UserProfileSuccess({required this.userProfileEntity});
}

final class UserProfileFailed extends UserProfileState {
  final Exception exception;

  UserProfileFailed({required this.exception});
}
