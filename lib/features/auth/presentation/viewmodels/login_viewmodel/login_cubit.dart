import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/auth/domain/entities/login_entity.dart';
import 'package:servicex/features/auth/domain/usecases/login_usecase.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  LoginCubit(this._loginUsecase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await _loginUsecase.login(email, password);
    switch (result) {
      case Success<LoginEntity>():
        await Future.wait([
          CacheService.setData(
            key: CacheConstants.userToken,
            value: result.data.token,
          ),
          CacheService.setData(
            key: CacheConstants.role,
            value: result.data.role,
          ),
        ]);
        emit(LoginSuccess(result.data));
        log('=====================> ${result.data}');
        log('=====================> ${result.data.token}');
        log('=====================> ${result.data.role}');
        break;
      case Fail<LoginEntity>():
        emit(LoginFailure('Error'));
        log('=====================> ${result.exception}');
        break;
    }
  }
}
