import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/home/data/data_sources/user_profile_data_sources.dart';
import 'package:servicex/features/home/domain/entities/user_profile_entity.dart';

@Injectable(as: MyBalanceDataSources)
class MyBalanceDataSourcesImpl implements MyBalanceDataSources {
  ApiService apiService;
  MyBalanceDataSourcesImpl({required this.apiService});
  @override
  Future<Result<MyBalanceEntity>> chargeBalance({
    required String code,
    required String token,
  }) {
    return executeApi(() async {
      var response = await apiService.chargeBalance(code, token);
      var data = response.toMyBalanceEntity();
      return data;
    });
  }
}

@Injectable(as: UserProfileDataSources)
class UserProfileDataSourcesImpl implements UserProfileDataSources {
  ApiService apiService;
  UserProfileDataSourcesImpl({required this.apiService});
  @override
  Future<Result<UserProfileEntity>> getUserProfile({required String token}) {
    return executeApi(() async {
      var response = await apiService.getUserProfile(token);
      var data = response.toUserProfileEntity();
      return data;
    });
  }
}
