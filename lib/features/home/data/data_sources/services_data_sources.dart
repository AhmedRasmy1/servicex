import '../../../../core/common/api_result.dart';
import '../../domain/entities/service_entity.dart';

abstract class ServicesDataSources {
  Future<Result<List<ServiceEntity>>> getAllServices();
}

abstract class TopServicesDataSources {
  Future<Result<List<TopServicesEntity>>> getTopServices();
}

abstract class TechniciansForServicesDataSources {
  Future<Result<List<TechniciansForServicesEntity>>> getTechniciansForServices(
    String serviceId,
  );
}
