import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/home/domain/entities/user_profile_entity.dart';

abstract class MyBalanceRepo {
  Future<Result<MyBalanceEntity>> chargeBalance({
    required String code,
    required String token,
  });
}

abstract class UserProfileRepo {
  Future<Result<UserProfileEntity>> getUserProfile({required String token});
}
