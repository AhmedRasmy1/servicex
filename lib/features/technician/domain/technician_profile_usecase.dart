import 'package:injectable/injectable.dart';
import '../../../core/common/api_result.dart';
import 'technician_profile_entity.dart';
import 'technician_profile_repo.dart';

@injectable
class TechnicianProfileUsecase {
  TechnicianProfileRepo technicianProfileRepo;
  TechnicianProfileUsecase(this.technicianProfileRepo);
  Future<Result<TechnicianProfileEntity>> getTechnicianProfile(String token) {
    return technicianProfileRepo.getTechnicianProfile(token);
  }
}
