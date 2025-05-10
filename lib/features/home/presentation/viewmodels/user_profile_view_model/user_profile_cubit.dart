import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/home/domain/entities/user_profile_entity.dart';
import 'package:servicex/features/home/domain/usecases/user_profile_use_case.dart';

part 'user_profile_state.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileUseCase _userProfileUseCase;
  UserProfileCubit(this._userProfileUseCase) : super(UserProfileInitial());
  Future<void> getUserProfile() async {
    emit(UserProfileLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    final result = await _userProfileUseCase.getUserProfile(token: token);
    switch (result) {
      case Success<UserProfileEntity>():
        emit(UserProfileSuccess(userProfileEntity: result.data));
        break;
      case Fail<UserProfileEntity>():
        emit(UserProfileFailed(exception: result.exception));
        break;
    }
  }
}
