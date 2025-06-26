import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/technician/data/technician_profile_repo_impl.dart';
import 'package:servicex/features/technician/domain/technician_profile_entity.dart';
import 'package:servicex/features/technician/domain/technician_profile_repo.dart';

@injectable
class TechnicianProfileUsecase {
  TechnicianProfileRepo technicianProfileRepo;
  TechnicianProfileUsecase(this.technicianProfileRepo);
  Future<Result<TechnicianProfileEntity>> getTechnicianProfile(String token) {
    return technicianProfileRepo.getTechnicianProfile(token);
  }
}
