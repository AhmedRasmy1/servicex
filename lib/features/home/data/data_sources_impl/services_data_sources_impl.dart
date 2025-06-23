import 'package:injectable/injectable.dart';
import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/services_data_sources.dart';
import '../../domain/entities/service_entity.dart';

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

@Injectable(as: TopServicesDataSources)
class TopServicesDataSourcesImpl implements TopServicesDataSources {
  ApiService apiService;
  TopServicesDataSourcesImpl({required this.apiService});
  @override
  Future<Result<List<TopServicesEntity>>> getTopServices() {
    return executeApi<List<TopServicesEntity>>(() async {
      var response = await apiService.getTopServices();
      var data =
          response.map((services) => services.toTopServicesEntity()).toList();
      return data;
    });
  }
}
