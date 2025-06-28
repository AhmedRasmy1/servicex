import '../../../core/common/api_result.dart';
import 'technician_profile_entity.dart';

abstract class TechnicianProfileRepo {
  Future<Result<TechnicianProfileEntity>> getTechnicianProfile(String token);
}
