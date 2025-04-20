part of 'services_cubit.dart';

@immutable
sealed class ServicesState {}

final class ServicesInitial extends ServicesState {}

final class ServicesLoading extends ServicesState {}

final class ServicesSuccess extends ServicesState {
  final List<ServiceEntity> services;

  ServicesSuccess({required this.services});
}

final class ServicesFailed extends ServicesState {
  final String errorMessage;

  ServicesFailed({required this.errorMessage});
}
