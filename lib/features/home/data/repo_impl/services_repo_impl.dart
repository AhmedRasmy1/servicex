import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/services_data_sources.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repo/services_repo.dart';

@Injectable(as: ServicesRepo)
class ServicesRepoImpl implements ServicesRepo {
  ServicesDataSources servicesDataSources;
  ServicesRepoImpl({required this.servicesDataSources});
  @override
  Future<Result<List<ServiceEntity>>> getAllServices() {
    return servicesDataSources.getAllServices();
  }
}
