import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:servicex/features/auth/data/models/login_model.dart';
import '../api_constants.dart';
part 'api_manager.g.dart';

@injectable
@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @FactoryMethod()
  factory ApiService(Dio dio) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginModel> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}
