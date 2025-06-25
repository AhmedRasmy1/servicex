import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/common/api_result.dart';
import '../../../../../core/utils/cashed_data_shared_preferences.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../../domain/usecases/user_profile_use_case.dart';

part 'my_balance_state.dart';

@injectable
class MyBalanceCubit extends Cubit<MyBalanceState> {
  final MyBalanceUseCase _myBalanceUseCase;
  MyBalanceCubit(this._myBalanceUseCase) : super(MyBalanceInitial());

  Future<void> chargeBalance({required String code}) async {
    emit(MyBalanceLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    final result = await _myBalanceUseCase.chargeBalance(
      code: code,
      token: token,
    );
    switch (result) {
      case Success<MyBalanceEntity>():
        emit(MyBalanceSuccess(myBalanceEntity: result.data));
        break;
      case Fail<MyBalanceEntity>():
        emit(MyBalanceFailed(exception: result.exception));
        break;
    }
  }
}
