import '../../../../core/common/api_result.dart';
import '../../domain/entities/service_entity.dart';

abstract class ServicesDataSources {
  Future<Result<List<ServiceEntity>>> getAllServices();
}
