import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/common/api_result.dart';
import '../../../domain/usecases/register_usecase.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _registerUsecase;
  RegisterCubit(this._registerUsecase) : super(RegisterInitial());

  Future<void> register({required FormData formData}) async {
    emit(RegisterLoading());
    final result = await _registerUsecase.register(formData: formData);
    switch (result) {
      case Success<void>():
        emit(RegisterSuccess(message: 'Registration successful'));
        break;
      case Fail<void>():
        emit(RegisterError(errorMessage: result.exception));
        break;
    }
  }
}
