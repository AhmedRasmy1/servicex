import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/home/data/data_sources/services_data_sources.dart';
import 'package:servicex/features/home/domain/entities/service_entity.dart';

@Injectable(as: ServicesDataSources)
class ServicesDataSourcesImpl implements ServicesDataSources {
  ApiService apiService;
  ServicesDataSourcesImpl({required this.apiService});
  @override
  Future<Result<List<ServiceEntity>>> getAllServices() {
    return executeApi<List<ServiceEntity>>(() async {
      var response = await apiService.getAllServices();
      var data =
          response.map((services) => services.toServicesEntity()).toList();
      return data;
    });
  }
}
