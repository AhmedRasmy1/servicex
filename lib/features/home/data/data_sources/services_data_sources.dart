import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/home/domain/entities/service_entity.dart';

abstract class ServicesDataSources {
  Future<Result<List<ServiceEntity>>> getAllServices();
}
