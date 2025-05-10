import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/home/data/data_sources/user_profile_data_sources.dart';
import 'package:servicex/features/home/domain/entities/user_profile_entity.dart';
import 'package:servicex/features/home/domain/repo/user_profile_repo.dart';

@Injectable(as: MyBalanceRepo)
class MyBalanceRepoImpl implements MyBalanceRepo {
  MyBalanceDataSources myBalanceDataSources;

  MyBalanceRepoImpl(this.myBalanceDataSources);
  @override
  Future<Result<MyBalanceEntity>> chargeBalance({
    required String code,
    required String token,
  }) {
    return myBalanceDataSources.chargeBalance(code: code, token: token);
  }
}

@Injectable(as: UserProfileRepo)
class UserProfileRepoImpl implements UserProfileRepo {
  UserProfileDataSources userProfileDataSources;

  UserProfileRepoImpl(this.userProfileDataSources);
  @override
  Future<Result<UserProfileEntity>> getUserProfile({required String token}) {
    return userProfileDataSources.getUserProfile(token: token);
  }
}
