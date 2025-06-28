import '../../../core/common/api_result.dart';
import '../domain/technician_profile_entity.dart';

abstract class TechnicianProfileDataSource {
  Future<Result<TechnicianProfileEntity>> getTechnicianProfile(String token);
}
