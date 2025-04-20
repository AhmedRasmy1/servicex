import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/home/data/data_sources/services_data_sources.dart';
import 'package:servicex/features/home/domain/entities/service_entity.dart';
import 'package:servicex/features/home/domain/repo/services_repo.dart';

@Injectable(as: ServicesRepo)
class ServicesRepoImpl implements ServicesRepo {
  ServicesDataSources servicesDataSources;
  ServicesRepoImpl({required this.servicesDataSources});
  @override
  Future<Result<List<ServiceEntity>>> getAllServices() {
    return servicesDataSources.getAllServices();
  }
}
