import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:servicex/features/auth/domain/repo/register_repo.dart';

@injectable
class RegisterUsecase {
  RegisterRepo registerRepo;
  RegisterUsecase({required this.registerRepo});

  Future register({required FormData formData}) async {
    return await registerRepo.register(formData: formData);
  }
}
