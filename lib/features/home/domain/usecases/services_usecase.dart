import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/home/domain/entities/service_entity.dart';
import 'package:servicex/features/home/domain/repo/services_repo.dart';

@injectable
class ServicesUsecase {
  ServicesRepo servicesRepo;
  ServicesUsecase({required this.servicesRepo});
  Future<Result<List<ServiceEntity>>> getAllServices() async {
    return await servicesRepo.getAllServices();
  }
}
