import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/common/api_result.dart';
import '../../../domain/entities/service_entity.dart';
import '../../../domain/usecases/services_usecase.dart';

part 'services_state.dart';

@injectable
class ServicesCubit extends Cubit<ServicesState> {
  final ServicesUsecase _servicesUsecase;
  ServicesCubit(this._servicesUsecase) : super(ServicesInitial());
  Future<void> getAllServices() async {
    emit(ServicesLoading());
    final result = await _servicesUsecase.getAllServices();
    log('result: $result');
    switch (result) {
      case Success<List<ServiceEntity>>():
        emit(ServicesSuccess(services: result.data));
        log('result.data: ${result.data}');
        break;
      case Fail<ServiceEntity>():
        emit(ServicesFailed(errorMessage: 'Error'));
        log('Error');
        break;
    }
  }
}

@injectable
class TopServicesCubit extends Cubit<ServicesState> {
  final TopServicesUsecase _topServicesUsecase;
  TopServicesCubit(this._topServicesUsecase) : super(ServicesInitial());
  Future<void> getTopServices() async {
    emit(ServicesLoading());
    final result = await _topServicesUsecase.getTopServices();
    log('result: $result');
    switch (result) {
      case Success<List<TopServicesEntity>>():
        emit(TopServicesSuccess(topServices: result.data));
        log('result.data: ${result.data}');
        break;
      case Fail<TopServicesEntity>():
        emit(TopServicesFailed(errorMessage: 'Error'));
        log('Error');
        break;
    }
  }
}

@injectable
class TechniciansForServicesCubit extends Cubit<ServicesState> {
  final TechniciansForServicesUsecase _techniciansForServicesUsecase;
  TechniciansForServicesCubit(this._techniciansForServicesUsecase)
    : super(ServicesInitial());
  Future<void> getTechniciansForServices(String serviceId) async {
    emit(ServicesLoading());
    final result = await _techniciansForServicesUsecase
        .getTechniciansForServices(serviceId);
    log('result: $result');
    switch (result) {
      case Success<List<TechniciansForServicesEntity>>():
        emit(
          TechniciansForServicesSuccess(techniciansForServices: result.data),
        );
        log('result.data: ${result.data}');
        break;
      case Fail<TechniciansForServicesEntity>():
        emit(TechniciansForServicesFailed(errorMessage: 'Error'));
        log('Error');
        break;
    }
  }
}
