import '../../../../core/common/api_result.dart';
import '../../domain/entities/user_profile_entity.dart';

abstract class MyBalanceDataSources {
  Future<Result<MyBalanceEntity>> chargeBalance({
    required String code,
    required String token,
  });
}

abstract class UserProfileDataSources {
  Future<Result<UserProfileEntity>> getUserProfile({required String token});
}
