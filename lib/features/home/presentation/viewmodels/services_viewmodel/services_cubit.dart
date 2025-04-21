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
