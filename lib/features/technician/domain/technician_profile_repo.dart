import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/technician/domain/technician_profile_entity.dart';

abstract class TechnicianProfileRepo {
  Future<Result<TechnicianProfileEntity>> getTechnicianProfile(String token);
}
