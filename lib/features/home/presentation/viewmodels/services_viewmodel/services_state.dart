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

final class TopServicesLoading extends ServicesState {}

final class TopServicesSuccess extends ServicesState {
  final List<TopServicesEntity> topServices;

  TopServicesSuccess({required this.topServices});
}

final class TopServicesFailed extends ServicesState {
  final String errorMessage;

  TopServicesFailed({required this.errorMessage});
}

final class TechniciansForServicesLoading extends ServicesState {}

final class TechniciansForServicesSuccess extends ServicesState {
  final List<TechniciansForServicesEntity> techniciansForServices;

  TechniciansForServicesSuccess({required this.techniciansForServices});
}

final class TechniciansForServicesFailed extends ServicesState {
  final String errorMessage;

  TechniciansForServicesFailed({required this.errorMessage});
}
