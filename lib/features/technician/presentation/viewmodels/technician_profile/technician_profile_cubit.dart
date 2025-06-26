import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/technician/domain/technician_profile_entity.dart';
import 'package:servicex/features/technician/domain/technician_profile_usecase.dart';

part 'technician_profile_state.dart';

@injectable
class TechnicianProfileCubit extends Cubit<TechnicianProfileState> {
  TechnicianProfileUsecase technicianProfileUsecase;
  TechnicianProfileCubit(this.technicianProfileUsecase)
    : super(TechnicianProfileInitial());

  Future<void> getTechnicianProfile() async {
    emit(TechnicianProfileLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    final result = await technicianProfileUsecase.getTechnicianProfile(token);
    switch (result) {
      case Success<TechnicianProfileEntity>():
        emit(TechnicianProfileSuccess(result.data));
        break;
      case Fail<TechnicianProfileEntity>():
        emit(TechnicianProfileError('${result.exception}'));
        break;
    }
  }
}
