import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/technician/data/technician_profile_data_source.dart';
import 'package:servicex/features/technician/domain/technician_profile_entity.dart';

@Injectable(as: TechnicianProfileDataSource)
class TechnicianProfileDataSourceImpl implements TechnicianProfileDataSource {
  ApiService apiService;
  TechnicianProfileDataSourceImpl(this.apiService);
  @override
  Future<Result<TechnicianProfileEntity>> getTechnicianProfile(String token) {
    return executeApi<TechnicianProfileEntity>(() async {
      final response = await apiService.getTechnicianProfile(token);
      return response.toTechnicianProfileEntity();
    });
  }
}
