import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../entities/user_profile_entity.dart';
import '../repo/user_profile_repo.dart';

@injectable
class MyBalanceUseCase {
  MyBalanceRepo myBalanceRepo;
  MyBalanceUseCase(this.myBalanceRepo);

  Future<Result<MyBalanceEntity>> chargeBalance({
    required String code,
    required String token,
  }) => myBalanceRepo.chargeBalance(code: code, token: token);
}

@injectable
class UserProfileUseCase {
  UserProfileRepo userProfileRepo;
  UserProfileUseCase(this.userProfileRepo);

  Future<Result<UserProfileEntity>> getUserProfile({required String token}) =>
      userProfileRepo.getUserProfile(token: token);
}
