import '../../../../core/common/api_result.dart';
import '../entities/service_entity.dart';

abstract class ServicesRepo {
  Future<Result<List<ServiceEntity>>> getAllServices();
}

abstract class TopServicesRepo {
  Future<Result<List<TopServicesEntity>>> getTopServices();
}

abstract class TechniciansForServicesRepo {
  Future<Result<List<TechniciansForServicesEntity>>> getTechniciansForServices(
    String serviceId,
  );
}
