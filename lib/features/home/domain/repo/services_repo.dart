import '../../../../core/common/api_result.dart';
import '../entities/service_entity.dart';

abstract class ServicesRepo {
  Future<Result<List<ServiceEntity>>> getAllServices();
}
