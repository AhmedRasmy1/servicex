import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../entities/service_entity.dart';
import '../repo/services_repo.dart';

@injectable
class ServicesUsecase {
  ServicesRepo servicesRepo;
  ServicesUsecase({required this.servicesRepo});
  Future<Result<List<ServiceEntity>>> getAllServices() async {
    return await servicesRepo.getAllServices();
  }
}

@injectable
class TopServicesUsecase {
  TopServicesRepo topServicesRepo;
  TopServicesUsecase({required this.topServicesRepo});
  Future<Result<List<TopServicesEntity>>> getTopServices() async {
    return await topServicesRepo.getTopServices();
  }
}

@injectable
class TechniciansForServicesUsecase {
  TechniciansForServicesRepo techniciansForServicesRepo;
  TechniciansForServicesUsecase({required this.techniciansForServicesRepo});
  Future<Result<List<TechniciansForServicesEntity>>> getTechniciansForServices(
    String serviceId,
  ) async {
    return await techniciansForServicesRepo.getTechniciansForServices(
      serviceId,
    );
  }
}
