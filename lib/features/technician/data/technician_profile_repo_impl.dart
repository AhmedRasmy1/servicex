import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/technician/data/technician_profile_data_source.dart';
import 'package:servicex/features/technician/domain/technician_profile_entity.dart';
import 'package:servicex/features/technician/domain/technician_profile_repo.dart';

@Injectable(as: TechnicianProfileRepo)
class TechnicianProfileRepoImpl implements TechnicianProfileRepo {
  TechnicianProfileDataSource technicianProfileDataSourceImpl;
  TechnicianProfileRepoImpl(this.technicianProfileDataSourceImpl);
  @override
  Future<Result<TechnicianProfileEntity>> getTechnicianProfile(String token) {
    return technicianProfileDataSourceImpl.getTechnicianProfile(token);
  }
}
