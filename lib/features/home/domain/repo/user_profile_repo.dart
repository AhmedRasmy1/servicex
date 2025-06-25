import '../../../../core/common/api_result.dart';
import '../entities/user_profile_entity.dart';

abstract class MyBalanceRepo {
  Future<Result<MyBalanceEntity>> chargeBalance({
    required String code,
    required String token,
  });
}

abstract class UserProfileRepo {
  Future<Result<UserProfileEntity>> getUserProfile({required String token});
}
