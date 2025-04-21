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
